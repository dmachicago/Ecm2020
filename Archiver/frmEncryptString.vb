Imports ECMEncryption

Public Class frmEncryptString

    Dim ENC As New ECMEncrypt

    Private Sub btnEncrypt_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnEncrypt.Click
        Dim S As String = txtUnencrypted.Text.Trim
        S = ENC.AES256EncryptString(S)
        txtEncrypted.Text = S
    End Sub

    Private Sub btnCopy_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCopy.Click
        Clipboard.Clear()
        Clipboard.SetText(txtEncrypted.Text)
        MessageBox.Show("The encrypted string is in the clipboard.")
    End Sub
End Class
