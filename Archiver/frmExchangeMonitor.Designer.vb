<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmExchangeMonitor
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
        Me.components = New System.ComponentModel.Container()
        Me.lblServer = New System.Windows.Forms.Label()
        Me.lblMessageInfo = New System.Windows.Forms.Label()
        Me.lblCnt = New System.Windows.Forms.Label()
        Me.lblMsg = New System.Windows.Forms.Label()
        Me.lblSpeed = New System.Windows.Forms.Label()
        Me.txTime = New System.Windows.Forms.Label()
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.eTimeAvg = New System.Windows.Forms.Label()
        Me.txAvg = New System.Windows.Forms.Label()
        Me.SuspendLayout()
        '
        'lblServer
        '
        Me.lblServer.AutoSize = True
        Me.lblServer.Location = New System.Drawing.Point(12, 9)
        Me.lblServer.Name = "lblServer"
        Me.lblServer.Size = New System.Drawing.Size(48, 13)
        Me.lblServer.TabIndex = 0
        Me.lblServer.Text = "lblServer"
        '
        'lblMessageInfo
        '
        Me.lblMessageInfo.AutoSize = True
        Me.lblMessageInfo.Location = New System.Drawing.Point(12, 33)
        Me.lblMessageInfo.Name = "lblMessageInfo"
        Me.lblMessageInfo.Size = New System.Drawing.Size(78, 13)
        Me.lblMessageInfo.TabIndex = 1
        Me.lblMessageInfo.Text = "lblMessageInfo"
        '
        'lblCnt
        '
        Me.lblCnt.AutoSize = True
        Me.lblCnt.Location = New System.Drawing.Point(12, 59)
        Me.lblCnt.Name = "lblCnt"
        Me.lblCnt.Size = New System.Drawing.Size(22, 13)
        Me.lblCnt.TabIndex = 2
        Me.lblCnt.Text = "cnt"
        '
        'lblMsg
        '
        Me.lblMsg.AutoSize = True
        Me.lblMsg.Location = New System.Drawing.Point(12, 84)
        Me.lblMsg.Name = "lblMsg"
        Me.lblMsg.Size = New System.Drawing.Size(50, 13)
        Me.lblMsg.TabIndex = 3
        Me.lblMsg.Text = "Message"
        '
        'lblSpeed
        '
        Me.lblSpeed.AutoSize = True
        Me.lblSpeed.Location = New System.Drawing.Point(12, 123)
        Me.lblSpeed.Name = "lblSpeed"
        Me.lblSpeed.Size = New System.Drawing.Size(36, 13)
        Me.lblSpeed.TabIndex = 4
        Me.lblSpeed.Text = "eTime"
        Me.ToolTip1.SetToolTip(Me.lblSpeed, "Time to download the one email")
        '
        'txTime
        '
        Me.txTime.AutoSize = True
        Me.txTime.Location = New System.Drawing.Point(12, 173)
        Me.txTime.Name = "txTime"
        Me.txTime.Size = New System.Drawing.Size(38, 13)
        Me.txTime.TabIndex = 5
        Me.txTime.Text = "txTime"
        Me.ToolTip1.SetToolTip(Me.txTime, "Time to process the one email")
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(12, 110)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(34, 13)
        Me.Label1.TabIndex = 6
        Me.Label1.Text = "Fetch"
        Me.ToolTip1.SetToolTip(Me.Label1, "Time to download the one email")
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(12, 160)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(33, 13)
        Me.Label2.TabIndex = 7
        Me.Label2.Text = "Apply"
        Me.ToolTip1.SetToolTip(Me.Label2, "Time to download the one email")
        '
        'eTimeAvg
        '
        Me.eTimeAvg.AutoSize = True
        Me.eTimeAvg.Location = New System.Drawing.Point(12, 136)
        Me.eTimeAvg.Name = "eTimeAvg"
        Me.eTimeAvg.Size = New System.Drawing.Size(55, 13)
        Me.eTimeAvg.TabIndex = 8
        Me.eTimeAvg.Text = "eTimeAvg"
        Me.ToolTip1.SetToolTip(Me.eTimeAvg, "Average time to download the one email")
        '
        'txAvg
        '
        Me.txAvg.AutoSize = True
        Me.txAvg.Location = New System.Drawing.Point(12, 186)
        Me.txAvg.Name = "txAvg"
        Me.txAvg.Size = New System.Drawing.Size(34, 13)
        Me.txAvg.TabIndex = 9
        Me.txAvg.Text = "txAvg"
        Me.ToolTip1.SetToolTip(Me.txAvg, "Average time to process the one email")
        '
        'frmExchangeMonitor
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(281, 105)
        Me.Controls.Add(Me.txAvg)
        Me.Controls.Add(Me.eTimeAvg)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.txTime)
        Me.Controls.Add(Me.lblSpeed)
        Me.Controls.Add(Me.lblMsg)
        Me.Controls.Add(Me.lblCnt)
        Me.Controls.Add(Me.lblMessageInfo)
        Me.Controls.Add(Me.lblServer)
        Me.Name = "frmExchangeMonitor"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
        Me.Text = "frmExchangeMonitor"
        Me.TopMost = True
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents lblServer As System.Windows.Forms.Label
    Friend WithEvents lblMessageInfo As System.Windows.Forms.Label
    Friend WithEvents lblCnt As System.Windows.Forms.Label
    Friend WithEvents lblMsg As System.Windows.Forms.Label
    Friend WithEvents lblSpeed As System.Windows.Forms.Label
    Friend WithEvents txTime As System.Windows.Forms.Label
    Friend WithEvents ToolTip1 As System.Windows.Forms.ToolTip
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents eTimeAvg As System.Windows.Forms.Label
    Friend WithEvents txAvg As System.Windows.Forms.Label
End Class
