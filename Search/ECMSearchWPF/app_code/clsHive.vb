Imports ECMEncryption

Public Class clsHive

    Dim LOG As New clsLogMain
    'Dim proxy As New SVCSearch.Service1Client
    'Dim EP As New clsEndPoint
    Dim ENC2 As New ECMEncrypt()



    Sub updateHiveServerName(ByVal TableName As String)
        Dim S As String = "Update " + TableName + " set RepoSvrName = (select @@SERVERNAME) where RepoName is null "
        S = ENC2.AES256EncryptString(S)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, S, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(S))

    End Sub
    Sub updateHiveRepoName(ByVal TableName As String)
        Dim S As String = "Update " + TableName + " set RepoSvrName = (SELECT DB_NAME() AS DataBaseName) where RepoName is null "
        'Dim proxy As New SVCSearch.Service1Client

        'EP.setSearchSvcEndPoint(proxy)
        S = ENC2.AES256EncryptString(s)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, S, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(S))

    End Sub

    Protected Overrides Sub Finalize()
        Try
        Finally
            MyBase.Finalize()      'define the destructor
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try
    End Sub

End Class
