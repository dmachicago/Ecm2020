Public Class frmEncString

    Private Sub btnEncrypt_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnEncrypt.Click
        Dim ENC As New clsEncrypt
        txtEnc.Text = ENC.AES256EncryptString(txtPlain.Text.Trim)
        ENC = Nothing
        GC.Collect()
        GC.WaitForPendingFinalizers()
    End Sub

    Private Sub btnClipboard_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnClipboard.Click
        Clipboard.Clear()
        Clipboard.SetText(txtEnc.Text.Trim)
        MessageBox.Show("Encrypted text placed into clipboard.")
    End Sub

    Private Sub btnClose_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnClose.Click
        Me.Close()
    End Sub
End Class
