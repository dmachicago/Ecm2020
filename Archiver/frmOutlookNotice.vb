Public Class frmOutlookNotice

    Dim UTIL As New clsUtility

    Dim iSec As Integer = 1

    Private Sub btnTerminate_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnTerminate.Click
        util.KillOutlookRunning()
    End Sub

    Private Sub Timer1_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Timer1.Tick
        statElapsedTime.Text = TimeOfDay.Second.ToString
        If iSec > 60 Then
            iSec = 1
        End If
        PB.Value = iSec
    End Sub

    Private Sub frmOutlookNotice_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        PB.Minimum = 0
        PB.Maximum = 60
    End Sub

End Class
