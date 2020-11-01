Public Class clsEndPoint

    Public Sub setSearchSvcEndPoint(proxy As SVCSearch.Service1Client)

        Dim CurrEndPoint As String = ""

        If LocalDebug = True Then
            SearchEndPoint = "http://localhost:59757/SVCSearch.svc"
            CurrEndPoint = SearchEndPoint
        Else
            CurrEndPoint = proxy.Endpoint.Address.ToString
        End If

        If (SearchEndPoint.Length = 0) Then
            Return
        End If

        Dim ServiceUri As New Uri(SearchEndPoint)
        Dim EPA As New System.ServiceModel.EndpointAddress(ServiceUri)

        proxy.Endpoint.Address = EPA
        'proxy2.Endpoint.Address = EPA

        GC.Collect()
        GC.WaitForPendingFinalizers()
    End Sub

End Class
