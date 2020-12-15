' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 07-16-2020
'
' Last Modified By : wdale
' Last Modified On : 07-16-2020
' ***********************************************************************
' <copyright file="clsHive.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
Imports ECMEncryption

''' <summary>
''' Class clsHive.
''' </summary>
Public Class clsHive

    ''' <summary>
    ''' The log
    ''' </summary>
    Dim LOG As New clsLogMain
    'Dim proxy As New SVCSearch.Service1Client
    'Dim EP As New clsEndPoint
    ''' <summary>
    ''' The en c2
    ''' </summary>
    Dim ENC2 As New ECMEncrypt()



    ''' <summary>
    ''' Updates the name of the hive server.
    ''' </summary>
    ''' <param name="TableName">Name of the table.</param>
    Sub updateHiveServerName(ByVal TableName As String)
        Dim S As String = "Update " + TableName + " set RepoSvrName = (select @@SERVERNAME) where RepoName is null "
        S = ENC2.AES256EncryptString(S)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, S, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(S))

    End Sub
    ''' <summary>
    ''' Updates the name of the hive repo.
    ''' </summary>
    ''' <param name="TableName">Name of the table.</param>
    Sub updateHiveRepoName(ByVal TableName As String)
        Dim S As String = "Update " + TableName + " set RepoSvrName = (SELECT DB_NAME() AS DataBaseName) where RepoName is null "
        'Dim proxy As New SVCSearch.Service1Client

        'EP.setSearchSvcEndPoint(proxy)
        S = ENC2.AES256EncryptString(S)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, S, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(S))

    End Sub

    ''' <summary>
    ''' Allows an object to try to free resources and perform other cleanup operations before it is reclaimed by garbage collection.
    ''' </summary>
    Protected Overrides Sub Finalize()
        Try
        Finally
            MyBase.Finalize()      'define the destructor
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try
    End Sub

End Class
