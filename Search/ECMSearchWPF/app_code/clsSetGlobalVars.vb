Public Class clsSetGlobalVars

    
    'Dim proxy As New SVCSearch.Service1Client
    'Dim EP As New clsEndPoint

    Dim gSecureID As string
    Sub New(ByVal iSecureID As Integer)
        gSecureID = iSecureID
    End Sub

    Sub setUserVariables(ByVal CurrUserGuidID As String)
        getIsAdmin(CurrUserGuidID)
        getIsGlobalSearcher(CurrUserGuidID)
    End Sub

    Sub getIsAdmin(ByVal CurrUserGuidID As String)

        'AddHandler ProxySearch.DBisAdminCompleted, AddressOf client_getIsAdmin
        'EP.setSearchSvcEndPoint(proxy)
        Dim BB As Boolean = ProxySearch.DBisAdmin(gSecureID, CurrUserGuidID)
        client_getIsAdmin(BB)
    End Sub
    'Sub client_getIsAdmin(ByVal sender As Object, ByVal e As SVCSearch.DBisAdminCompletedEventArgs)
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
