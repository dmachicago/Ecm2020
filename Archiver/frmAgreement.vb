Public Class frmAgreement

    Private Sub btnProcess_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnProcess.Click
        Me.Dispose()
    End Sub

    Private Sub ckAgree_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckAgree.CheckedChanged
        If ckAgree.Checked = True Then
            gLegalAgree = True            
            Me.ckDisagree.Checked = False
        End If
    End Sub

    Private Sub ckDisagree_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckDisagree.CheckedChanged
        If ckDisagree.Checked = True Then
            gLegalAgree = False
            ckAgree.Checked = False
        End If
    End Sub

    Private Sub frmAgreement_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        ckDisagree.Checked = True
    End Sub
End Class
