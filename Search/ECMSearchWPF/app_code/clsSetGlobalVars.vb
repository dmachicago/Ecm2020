' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="clsSetGlobalVars.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
''' <summary>
''' Class clsSetGlobalVars.
''' </summary>
Public Class clsSetGlobalVars


    'Dim proxy As New SVCSearch.Service1Client
    'Dim EP As New clsEndPoint

    ''' <summary>
    ''' The g secure identifier
    ''' </summary>
    Dim gSecureID As String
    ''' <summary>
    ''' Initializes a new instance of the <see cref="clsSetGlobalVars"/> class.
    ''' </summary>
    ''' <param name="iSecureID">The i secure identifier.</param>
    Sub New(ByVal iSecureID As Integer)
        gSecureID = iSecureID
    End Sub

    ''' <summary>
    ''' Sets the user variables.
    ''' </summary>
    ''' <param name="CurrUserGuidID">The curr user unique identifier identifier.</param>
    Sub setUserVariables(ByVal CurrUserGuidID As String)
        getIsAdmin(CurrUserGuidID)
        getIsGlobalSearcher(CurrUserGuidID)
    End Sub

    ''' <summary>
    ''' Gets the is admin.
    ''' </summary>
    ''' <param name="CurrUserGuidID">The curr user unique identifier identifier.</param>
    Sub getIsAdmin(ByVal CurrUserGuidID As String)

        'AddHandler ProxySearch.DBisAdminCompleted, AddressOf client_getIsAdmin
        'EP.setSearchSvcEndPoint(proxy)
        Dim BB As Boolean = ProxySearch.DBisAdmin(gSecureID, CurrUserGuidID)
        client_getIsAdmin(BB)
    End Sub
    'Sub client_getIsAdmin(ByVal sender As Object, ByVal e As SVCSearch.DBisAdminCompletedEventArgs)
    ''' <summary>
    ''' Clients the get is admin.
    ''' </summary>
    ''' <param name="BB">if set to <c>true</c> [bb].</param>
    Sub client_getIsAdmin(BB As Boolean)
        If BB Then
            gIsAdmin = BB
            _isAdmin = BB
        Else
            gIsAdmin = False
            _isAdmin = False
        End If
        'RemoveHandler ProxySearch.DBisAdminCompleted, AddressOf client_getIsAdmin
    End Sub

    ''' <summary>
    ''' Gets the is global searcher.
    ''' </summary>
    ''' <param name="CurrUserGuidID">The curr user unique identifier identifier.</param>
    Sub getIsGlobalSearcher(ByVal CurrUserGuidID As String)
        'AddHandler ProxySearch.DBisGlobalSearcherCompleted, AddressOf client_getIsGlobalSearcher
        'EP.setSearchSvcEndPoint(proxy)
        gIsGlobalSearcher = ProxySearch.DBisGlobalSearcher(gSecureID, CurrUserGuidID)
    End Sub

    'Sub client_getIsGlobalSearcher(ByVal sender As Object, ByVal e As SVCSearch.DBisGlobalSearcherCompletedEventArgs)
    '    If RC Then
    '        gIsGlobalSearcher = e.Result
    '    Else
    '        gIsGlobalSearcher = False
    '    End If
    '    'RemoveHandler ProxySearch.DBisGlobalSearcherCompleted, AddressOf client_getIsGlobalSearcher
    'End Sub

    ''' <summary>
    ''' Sets the xx search SVC end point.
    ''' </summary>
    Private Sub setXXSearchSvcEndPoint()

        If (SearchEndPoint.Length = 0) Then
            Return
        End If

        Dim ServiceUri As New Uri(SearchEndPoint)
        Dim EPA As New System.ServiceModel.EndpointAddress(ServiceUri)

        ProxySearch.Endpoint.Address = EPA
        GC.Collect()
        GC.WaitForPendingFinalizers()
    End Sub

End Class
