<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmUser
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
        Me.lblSecureSvr = New System.Windows.Forms.Label()
        Me.btnLoadSecure = New System.Windows.Forms.Button()
        Me.dgSecureServer = New System.Windows.Forms.DataGridView()
        Me.DataGridView1 = New System.Windows.Forms.DataGridView()
        Me.lblReporSvr = New System.Windows.Forms.Label()
        Me.btnLoadRepo = New System.Windows.Forms.Button()
        Me.btnDelRepo = New System.Windows.Forms.Button()
        Me.btnAddRepo = New System.Windows.Forms.Button()
        Me.dgRepo = New System.Windows.Forms.DataGridView()
        CType(Me.SplitContainer1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SplitContainer1.Panel1.SuspendLayout()
        Me.SplitContainer1.Panel2.SuspendLayout()
        Me.SplitContainer1.SuspendLayout()
        CType(Me.dgSecureServer, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.dgRepo, System.ComponentModel.ISupportInitialize).BeginInit()
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
        Me.SplitContainer1.Panel1.Controls.Add(Me.lblSecureSvr)
        Me.SplitContainer1.Panel1.Controls.Add(Me.btnLoadSecure)
        Me.SplitContainer1.Panel1.Controls.Add(Me.dgSecureServer)
        Me.SplitContainer1.Panel1.Controls.Add(Me.DataGridView1)
        '
        'SplitContainer1.Panel2
        '
        Me.SplitContainer1.Panel2.Controls.Add(Me.lblReporSvr)
        Me.SplitContainer1.Panel2.Controls.Add(Me.btnLoadRepo)
        Me.SplitContainer1.Panel2.Controls.Add(Me.btnDelRepo)
        Me.SplitContainer1.Panel2.Controls.Add(Me.btnAddRepo)
        Me.SplitContainer1.Panel2.Controls.Add(Me.dgRepo)
        Me.SplitContainer1.Size = New System.Drawing.Size(1159, 660)
        Me.SplitContainer1.SplitterDistance = 587
        Me.SplitContainer1.TabIndex = 0
        '
        'lblSecureSvr
        '
        Me.lblSecureSvr.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.lblSecureSvr.AutoSize = True
        Me.lblSecureSvr.Location = New System.Drawing.Point(11, 568)
        Me.lblSecureSvr.Name = "lblSecureSvr"
        Me.lblSecureSvr.Size = New System.Drawing.Size(99, 17)
        Me.lblSecureSvr.TabIndex = 8
        Me.lblSecureSvr.Text = "Secure Server"
        '
        'btnLoadSecure
        '
        Me.btnLoadSecure.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.btnLoadSecure.Location = New System.Drawing.Point(14, 606)
        Me.btnLoadSecure.Name = "btnLoadSecure"
        Me.btnLoadSecure.Size = New System.Drawing.Size(96, 38)
        Me.btnLoadSecure.TabIndex = 7
        Me.btnLoadSecure.Text = "Refresh"
        Me.btnLoadSecure.UseVisualStyleBackColor = True
        '
        'dgSecureServer
        '
        Me.dgSecureServer.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.dgSecureServer.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.dgSecureServer.Location = New System.Drawing.Point(14, 16)
        Me.dgSecureServer.Name = "dgSecureServer"
        Me.dgSecureServer.RowTemplate.Height = 24
        Me.dgSecureServer.Size = New System.Drawing.Size(554, 549)
        Me.dgSecureServer.TabIndex = 0
        '
        'DataGridView1
        '
        Me.DataGridView1.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.DataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.DataGridView1.Location = New System.Drawing.Point(14, 16)
        Me.DataGridView1.Name = "DataGridView1"
        Me.DataGridView1.RowTemplate.Height = 24
        Me.DataGridView1.Size = New System.Drawing.Size(554, 431)
        Me.DataGridView1.TabIndex = 0
        '
        'lblReporSvr
        '
        Me.lblReporSvr.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.lblReporSvr.AutoSize = True
        Me.lblReporSvr.Location = New System.Drawing.Point(16, 568)
        Me.lblReporSvr.Name = "lblReporSvr"
        Me.lblReporSvr.Size = New System.Drawing.Size(88, 17)
        Me.lblReporSvr.TabIndex = 11
        Me.lblReporSvr.Text = "Repo Server"
        '
        'btnLoadRepo
        '
        Me.btnLoadRepo.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnLoadRepo.Location = New System.Drawing.Point(456, 606)
        Me.btnLoadRepo.Name = "btnLoadRepo"
        Me.btnLoadRepo.Size = New System.Drawing.Size(96, 38)
        Me.btnLoadRepo.TabIndex = 10
        Me.btnLoadRepo.Text = "Refresh"
        Me.btnLoadRepo.UseVisualStyleBackColor = True
        '
        'btnDelRepo
        '
        Me.btnDelRepo.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnDelRepo.Location = New System.Drawing.Point(118, 606)
        Me.btnDelRepo.Name = "btnDelRepo"
        Me.btnDelRepo.Size = New System.Drawing.Size(96, 38)
        Me.btnDelRepo.TabIndex = 6
        Me.btnDelRepo.Text = "Disable"
        Me.btnDelRepo.UseVisualStyleBackColor = True
        '
        'btnAddRepo
        '
        Me.btnAddRepo.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnAddRepo.Location = New System.Drawing.Point(16, 606)
        Me.btnAddRepo.Name = "btnAddRepo"
        Me.btnAddRepo.Size = New System.Drawing.Size(96, 38)
        Me.btnAddRepo.TabIndex = 5
        Me.btnAddRepo.Text = "Enable"
        Me.btnAddRepo.UseVisualStyleBackColor = True
        '
        'dgRepo
        '
        Me.dgRepo.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.dgRepo.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.dgRepo.Location = New System.Drawing.Point(16, 16)
        Me.dgRepo.Name = "dgRepo"
        Me.dgRepo.RowTemplate.Height = 24
        Me.dgRepo.Size = New System.Drawing.Size(536, 549)
        Me.dgRepo.TabIndex = 0
        '
        'frmUser
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(8.0!, 16.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(1159, 660)
        Me.Controls.Add(Me.SplitContainer1)
        Me.Name = "frmUser"
        Me.Text = "frmUser"
        Me.SplitContainer1.Panel1.ResumeLayout(False)
        Me.SplitContainer1.Panel1.PerformLayout()
        Me.SplitContainer1.Panel2.ResumeLayout(False)
        Me.SplitContainer1.Panel2.PerformLayout()
        CType(Me.SplitContainer1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.SplitContainer1.ResumeLayout(False)
        CType(Me.dgSecureServer, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.dgRepo, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub

    Friend WithEvents SplitContainer1 As SplitContainer
    Friend WithEvents dgSecureServer As DataGridView
    Friend WithEvents DataGridView1 As DataGridView
    Friend WithEvents btnDelRepo As Button
    Friend WithEvents btnAddRepo As Button
    Friend WithEvents dgRepo As DataGridView
    Friend WithEvents btnLoadSecure As Button
    Friend WithEvents btnLoadRepo As Button
    Friend WithEvents lblSecureSvr As Label
    Friend WithEvents lblReporSvr As Label
End Class
