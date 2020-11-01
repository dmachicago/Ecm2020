<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmLibraryAssignment
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
        Me.cbLibrary = New System.Windows.Forms.ComboBox
        Me.btnAssign = New System.Windows.Forms.Button
        Me.txtFolderName = New System.Windows.Forms.TextBox
        Me.SB = New System.Windows.Forms.TextBox
        Me.btnRemove = New System.Windows.Forms.Button
        Me.cbAssignedLibs = New System.Windows.Forms.ComboBox
        Me.txtFolderID = New System.Windows.Forms.TextBox
        Me.TT = New System.Windows.Forms.ToolTip(Me.components)
        Me.Timer1 = New System.Windows.Forms.Timer(Me.components)
        Me.Label1 = New System.Windows.Forms.Label
        Me.Label2 = New System.Windows.Forms.Label
        Me.SuspendLayout()
        '
        'cbLibrary
        '
        Me.cbLibrary.FormattingEnabled = True
        Me.cbLibrary.Location = New System.Drawing.Point(12, 23)
        Me.cbLibrary.Name = "cbLibrary"
        Me.cbLibrary.Size = New System.Drawing.Size(232, 21)
        Me.cbLibrary.TabIndex = 0
        '
        'btnAssign
        '
        Me.btnAssign.Location = New System.Drawing.Point(12, 50)
        Me.btnAssign.Name = "btnAssign"
        Me.btnAssign.Size = New System.Drawing.Size(106, 21)
        Me.btnAssign.TabIndex = 1
        Me.btnAssign.Text = "Assign"
        Me.btnAssign.UseVisualStyleBackColor = True
        '
        'txtFolderName
        '
        Me.txtFolderName.Enabled = False
        Me.txtFolderName.Location = New System.Drawing.Point(11, 87)
        Me.txtFolderName.Name = "txtFolderName"
        Me.txtFolderName.Size = New System.Drawing.Size(471, 20)
        Me.txtFolderName.TabIndex = 2
        '
        'SB
        '
        Me.SB.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.SB.Enabled = False
        Me.SB.Location = New System.Drawing.Point(11, 113)
        Me.SB.Name = "SB"
        Me.SB.Size = New System.Drawing.Size(471, 20)
        Me.SB.TabIndex = 3
        '
        'btnRemove
        '
        Me.btnRemove.Location = New System.Drawing.Point(376, 50)
        Me.btnRemove.Name = "btnRemove"
        Me.btnRemove.Size = New System.Drawing.Size(106, 21)
        Me.btnRemove.TabIndex = 4
        Me.btnRemove.Text = "Remove"
        Me.btnRemove.UseVisualStyleBackColor = True
        '
        'cbAssignedLibs
        '
        Me.cbAssignedLibs.FormattingEnabled = True
        Me.cbAssignedLibs.Location = New System.Drawing.Point(250, 23)
        Me.cbAssignedLibs.Name = "cbAssignedLibs"
        Me.cbAssignedLibs.Size = New System.Drawing.Size(232, 21)
        Me.cbAssignedLibs.TabIndex = 5
        '
        'txtFolderID
        '
        Me.txtFolderID.Location = New System.Drawing.Point(12, 139)
        Me.txtFolderID.Name = "txtFolderID"
        Me.txtFolderID.Size = New System.Drawing.Size(470, 20)
        Me.txtFolderID.TabIndex = 6
        '
        'TT
        '
        Me.TT.ToolTipTitle = "Use this form to assign a LIBRARY to a directory."
        '
        'Timer1
        '
        Me.Timer1.Enabled = True
        Me.Timer1.Interval = 5000
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.BackColor = System.Drawing.Color.Transparent
        Me.Label1.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.ForeColor = System.Drawing.Color.WhiteSmoke
        Me.Label1.Location = New System.Drawing.Point(12, 5)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(107, 15)
        Me.Label1.TabIndex = 7
        Me.Label1.Text = "Available Libraries"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.BackColor = System.Drawing.Color.Transparent
        Me.Label2.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.ForeColor = System.Drawing.Color.WhiteSmoke
        Me.Label2.Location = New System.Drawing.Point(247, 5)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(108, 15)
        Me.Label2.TabIndex = 8
        Me.Label2.Text = "Assigned Libraries"
        '
        'frmLibraryAssignment
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch
        Me.ClientSize = New System.Drawing.Size(491, 169)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.txtFolderID)
        Me.Controls.Add(Me.cbAssignedLibs)
        Me.Controls.Add(Me.btnRemove)
        Me.Controls.Add(Me.SB)
        Me.Controls.Add(Me.txtFolderName)
        Me.Controls.Add(Me.btnAssign)
        Me.Controls.Add(Me.cbLibrary)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "frmLibraryAssignment"
        Me.Text = "Library Assignment Form"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents cbLibrary As System.Windows.Forms.ComboBox
    Friend WithEvents btnAssign As System.Windows.Forms.Button
    Friend WithEvents txtFolderName As System.Windows.Forms.TextBox
    Friend WithEvents SB As System.Windows.Forms.TextBox
    Friend WithEvents btnRemove As System.Windows.Forms.Button
    Friend WithEvents cbAssignedLibs As System.Windows.Forms.ComboBox
    Friend WithEvents txtFolderID As System.Windows.Forms.TextBox
    Friend WithEvents TT As System.Windows.Forms.ToolTip
    Friend WithEvents Timer1 As System.Windows.Forms.Timer
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
End Class
