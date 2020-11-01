Public Class frmPasswordChange

    Public PW1 As String = ""
    Public PW2 As String = ""

    Private Sub btnEnter_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnEnter.Click
        If txtPw2.Text.Equals(txtPw1.Text.Trim) Then
            PW1 = txtPw1.Text.Trim
            PW2 = txtPw2.Text.Trim
            SB.Text = "Successful."
            Me.Close()
        Else
            SB.Text = "Passwords do not match."
        End If
    End Sub
End Class
