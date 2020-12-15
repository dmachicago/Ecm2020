' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 07-16-2020
'
' Last Modified By : wdale
' Last Modified On : 07-16-2020
' ***********************************************************************
' <copyright file="GlobalMod.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
Imports ECMEncryption

''' <summary>
''' Class GlobalMod.
''' </summary>
Module GlobalMod

    ''' <summary>
    ''' The log
    ''' </summary>
    Dim LOG As New clsLogMain
    ''' <summary>
    ''' The enc
    ''' </summary>
    Dim ENC As New ECMEncrypt

    ''' <summary>
    ''' gs the fetch thesaurus cs.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function gFetchThesaurusCS() As String

        Dim CS As String = System.Configuration.ConfigurationManager.AppSettings("ECMThesaurus")
        Dim pw As String = System.Configuration.ConfigurationManager.AppSettings("EncPW")
        pw = ENC.AES256DecryptString(pw)
        CS = CS.Replace("@@PW@@", pw)

        Return CS
    End Function

    ''' <summary>
    ''' gs the fetch cs.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function gFetchCS() As String

        Dim CS As String = System.Configuration.ConfigurationManager.AppSettings("ECMREPO")
        Dim pw As String = System.Configuration.ConfigurationManager.AppSettings("EncPW")
        pw = ENC.AES256DecryptString(pw)
        CS = CS.Replace("@@PW@@", pw)

        Return CS
    End Function


    ''' <summary>
    ''' gs the log SQL.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="S">The s.</param>
    Public Sub gLogSQL(RC As Boolean, S As String)
        If Not RC Then
            Dim ErrSql As String = S
            LOG.WriteToSqlLog("ERROR clsLibEmail 100: " + ErrSql)
        End If
    End Sub

    ''' <summary>
    ''' Gets the user unique identifier identifier.
    ''' </summary>
    ''' <param name="UserID">The user identifier.</param>
    ''' <returns>System.String.</returns>
    Function getUserGuidID(UserID As String) As String
        If UserID.Length = 0 Then
            Console.WriteLine("ERROR getUserGuidID : UserID missing, aborting")
            Return ""
        End If
        Dim S As String = ProxySearch.getUserGuidID(gSecureID, UserID)
        Return S
    End Function

End Module
