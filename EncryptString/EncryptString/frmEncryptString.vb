Imports System.Data.SqlClient
Imports ECMEncryption

Public Class frmEncryptString

    Dim ENC As New ECMEncrypt()
    Dim RC As Integer = 0
    Dim RetMsg As String = ""

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

    Private Sub btnTestConnStr_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnTestConnStr.Click

        Dim CS As String = txtConnstr.Text.Trim
        Dim CONN As New SqlConnection
        Try
            CONN.ConnectionString = CS
            CONN.Open()
            MessageBox.Show("Connection GOOD.")
        Catch ex As Exception
            MessageBox.Show("FAILED Connection : + " + ex.Message)
        Finally
            If CONN IsNot Nothing Then
                If CONN.State = ConnectionState.Closed Then
                Else
                    CONN.Close()
                End If
                CONN.Dispose()
                GC.Collect()
            End If
        End Try

    End Sub
End Class
