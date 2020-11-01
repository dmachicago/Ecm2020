Imports ECMEncryption

Module GlobalMod

    Dim LOG As New clsLogMain
    Dim ENC As New ECMEncrypt

    Public Function gFetchThesaurusCS() As String

        Dim CS As String = System.Configuration.ConfigurationManager.AppSettings("ECMThesaurus")
        Dim pw As String = System.Configuration.ConfigurationManager.AppSettings("EncPW")
        pw = ENC.AES256DecryptString(pw)
        CS = CS.Replace("@@PW@@", pw)

        Return CS
    End Function

    Public Function gFetchCS() As String

        Dim CS As String = System.Configuration.ConfigurationManager.AppSettings("ECMREPO")
        Dim pw As String = System.Configuration.ConfigurationManager.AppSettings("EncPW")
        pw = ENC.AES256DecryptString(pw)
        CS = CS.Replace("@@PW@@", pw)

        Return CS
    End Function


    Public Sub gLogSQL(RC As Boolean, S As String)
        If Not RC Then
            Dim ErrSql As String = S
            LOG.WriteToSqlLog("ERROR clsLibEmail 100: " + ErrSql)
        End If
    End Sub

    Function getUserGuidID(UserID As String) As String
        If UserID.Length = 0 Then
            Console.WriteLine("ERROR getUserGuidID : UserID missing, aborting")
            Return ""
        End If
        Dim S As String = ProxySearch.getUserGuidID(gSecureID, UserID)
        Return S
    End Function

End Module
