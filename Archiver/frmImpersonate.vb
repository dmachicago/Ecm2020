Imports System.IO
Imports ECMEncryption

Public Class frmImpersonate

    Dim UTIL As New clsUtility
    Dim DBARCH As New clsDatabaseARCH
    Dim ENC As New ECMEncrypt
    Dim LOG As New clsLogging

    Private Sub btnAssign_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAssign.Click
        If txtPw1.Text.Equals(txtPw2.Text) Then
        Else
            MessageBox.Show("The passwords do not match, returning.")
            Return
        End If

        Dim EPW As String = ENC.AES256EncryptString(txtPw1.Text)
        Dim I As Integer = -1
        I = DBARCH.ValidateUserByUid(txtUserID.Text.Trim, EPW)

        If I <= 0 Then
            messagebox.show("This user id or password is incorrect, please verify.")
            Return
        End If

Dim msg AS String  = "This sets the defined user as the default login for this machine.  " + vbCrLf + " There is the possibility that this offers security risks." + vbCrLf + " In assigning this user, you and your organization accept all the potential risks." 
        Dim dlgRes As DialogResult = MessageBox.Show(msg, "Set Default Login", MessageBoxButtons.YesNo)
        If dlgRes = Windows.Forms.DialogResult.No Then
            Return
        End If

        My.Settings.DefaultLoginID = txtUserID.Text.Trim
        My.Settings.DefaultLoginPW = EPW
        My.Settings.Save()

        Dim FQN As String = ""
        UTIL.getImpersonateFileName(FQN)

        Try
            Dim objWriter As New System.IO.StreamWriter(FQN, False)
            objWriter.Write(txtUserID.Text)
            objWriter.Close()
            objWriter.Dispose()
            messagebox.show("Success: user ID " + txtUserID.Text + " will be used as the default login for this machine.")
        Catch ex As Exception
            messagebox.show("Fatal ERROR: Failed to create the file, please ensure you have the required authority." + vbCrLf + ex.Message)
            Return
        End Try

    End Sub

    Private Sub btnRemoveAssignment_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRemoveAssignment.Click
Dim msg AS String  = "This removes the default impersonation for this machine - Are you sure.  " 
        Dim dlgRes As DialogResult = MessageBox.Show(msg, "Remove Impersonation", MessageBoxButtons.YesNo)
        If dlgRes = Windows.Forms.DialogResult.No Then
            Return
        End If


        My.Settings.DefaultLoginID = ""
        My.Settings.DefaultLoginPW = ""
        My.Settings.Save()

        Dim FQN As String = ""
        UTIL.getImpersonateFileName(FQN)

        Try
            File.Delete(FQN)
            LOG.WriteToDeleteLog("DELETE FAILURE 01|" + FQN)
            MessageBox.show("Success: impersonation removed.")
        Catch ex As Exception

            messagebox.show("Fatal ERROR: Failed to remove impersonation." + vbCrLf + ex.Message)
            Return
        End Try
    End Sub

    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        Me.Close()
    End Sub
End Class
