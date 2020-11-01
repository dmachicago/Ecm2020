Public Class frmNotifyMessage

    Dim TimerCount As Integer = 0
    Public MsgToDisplay As String = ""

    Sub New()
        InitializeComponent()

        If (gNotifyMsg.Length.Equals(0)) Then
            Me.Close()
            Return
        End If
        txtMsg.Text = gNotifyMsg
        T1_Tick(Nothing, Nothing)
    End Sub

    Private Sub T1_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles T1.Tick
        TimerCount += 1

        txtMsg.Text = gNotifyMsg
        Me.Refresh()
        Application.DoEvents()

        If TimerCount >= 6 Then
            Me.Close()
        End If
    End Sub

End Class
