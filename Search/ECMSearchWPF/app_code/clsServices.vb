Public Class clsgetUserParm

    
    Public tVal As String = ""
    Dim gSecureID As String = -1

    'Dim EP As New clsEndPoint

    'Dim proxy As New SVCSearch.Service1Client

    Sub New()
        gSecureID = _SecureID
    End Sub
    Public Property tVar() As String
        Get
            Return tVal
        End Get
        Set(ByVal value As String)
            tVal = value
        End Set
    End Property ' Hour

    Sub getUserVar(ByVal VariableID As String, ByRef ReturnedValue As String)
        '"user_MaxRecordsToFetch"

        'AddHandler ProxySearch.getUserParmCompleted, AddressOf client_getUserParm
        'EP.setSearchSvcEndPoint(proxy)
        ProxySearch.getUserParm(gSecureID, VariableID, ReturnedValue)
        client_getUserParm(VariableID)
    End Sub

    Sub client_getUserParm(VariableID As String)
        If VariableID.Length > 0 Then
            tVal = VariableID
        Else
            tVal = ""
        End If
        'RemoveHandler ProxySearch.getUserParmCompleted, AddressOf client_getUserParm
    End Sub
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

