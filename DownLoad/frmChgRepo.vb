Public Class frmChgRepo

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        PopulateRepoComboBox()
    End Sub
    Sub PopulateRepoComboBox()


        'cbRepoID.Visibility = Windows.Visibility.Collapsed
        'pwEncryptPW.Visibility = Windows.Visibility.Collapsed
        'btnGetRepos.Visibility = Windows.Visibility.Collapsed

        'MessageBox.Show("Get REPOS 01")

        Dim CS As String = ""
        Dim CompanyID As String = txtCompanyID.Text
        Dim RC As Boolean = True
        Dim RetMsg As String = ""

        If CompanyID.Trim.Length = 0 Then
            MessageBox.Show("Please supply your company ID and password.")
            Return
        End If

        AddHandler ProxySearch.PopulateSecureLoginCBCompleted, AddressOf client_PopulateSecureLoginCB
        setSearchSvcEndPoint()
        ProxySearch.PopulateSecureLoginCBAsync(SecureID, ListOfRepoIS, CompanyID, RC, RetMsg)

    End Sub
End Class