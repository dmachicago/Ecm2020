Public Class frmNotify2
Public Title AS String  = "" 

    Private Sub frmNotify2_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        lblEmailMsg.Text = Now.ToString
    End Sub

End Class
