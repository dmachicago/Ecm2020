<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmAgreement
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(frmAgreement))
        Me.txtAgreement = New System.Windows.Forms.TextBox
        Me.ckAgree = New System.Windows.Forms.CheckBox
        Me.ckDisagree = New System.Windows.Forms.CheckBox
        Me.btnProcess = New System.Windows.Forms.Button
        Me.SuspendLayout()
        '
        'txtAgreement
        '
        Me.txtAgreement.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
                    Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtAgreement.Location = New System.Drawing.Point(12, 12)
        Me.txtAgreement.Multiline = True
        Me.txtAgreement.Name = "txtAgreement"
        Me.txtAgreement.ReadOnly = True
        Me.txtAgreement.ScrollBars = System.Windows.Forms.ScrollBars.Both
        Me.txtAgreement.Size = New System.Drawing.Size(465, 155)
        Me.txtAgreement.TabIndex = 10
        '
        'ckAgree
        '
        Me.ckAgree.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.ckAgree.AutoSize = True
        Me.ckAgree.Location = New System.Drawing.Point(277, 194)
        Me.ckAgree.Name = "ckAgree"
        Me.ckAgree.Size = New System.Drawing.Size(54, 17)
        Me.ckAgree.TabIndex = 2
        Me.ckAgree.Text = "Agree"
        Me.ckAgree.UseVisualStyleBackColor = True
        '
        'ckDisagree
        '
        Me.ckDisagree.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.ckDisagree.AutoSize = True
        Me.ckDisagree.Location = New System.Drawing.Point(277, 237)
        Me.ckDisagree.Name = "ckDisagree"
        Me.ckDisagree.Size = New System.Drawing.Size(68, 17)
        Me.ckDisagree.TabIndex = 1
        Me.ckDisagree.Text = "Disagree"
        Me.ckDisagree.UseVisualStyleBackColor = True
        '
        'btnProcess
        '
        Me.btnProcess.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnProcess.Location = New System.Drawing.Point(376, 194)
        Me.btnProcess.Name = "btnProcess"
        Me.btnProcess.Size = New System.Drawing.Size(101, 60)
        Me.btnProcess.TabIndex = 0
        Me.btnProcess.Text = "Proceed"
        Me.btnProcess.UseVisualStyleBackColor = True
        '
        'frmAgreement
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(489, 267)
        Me.Controls.Add(Me.btnProcess)
        Me.Controls.Add(Me.ckDisagree)
        Me.Controls.Add(Me.ckAgree)
        Me.Controls.Add(Me.txtAgreement)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Name = "frmAgreement"
        Me.Text = "Legal Agreement"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents txtAgreement As System.Windows.Forms.TextBox
    Friend WithEvents ckAgree As System.Windows.Forms.CheckBox
    Friend WithEvents ckDisagree As System.Windows.Forms.CheckBox
    Friend WithEvents btnProcess As System.Windows.Forms.Button
End Class
