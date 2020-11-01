Public Class clsCommonFunctions


    'Dim proxy As New SVCSearch.Service1Client
    Dim LOG As New clsLogMain
    Dim gSecureID As string
    'Dim EP As New clsEndPoint

    Sub RemoveSingleQuotes(ByRef tVal As String)
        tVal = tVal.Replace("''", "'")
        tVal = tVal.Replace("'", "''")
    End Sub

    Sub New()
        gSecureID = _SecureID
    End Sub

    Public Sub SaveClick(ByVal ID As Integer, ByVal UID As String)
        Dim RC As Boolean = True
        'AddHandler ProxySearch.SaveClickStatsCompleted, AddressOf client_SaveClickStats
        'EP.setSearchSvcEndPoint(proxy)
        ProxySearch.SaveClickStats(_SecureID, ID, UID, RC)
        client_SaveClickStats(RC)
    End Sub

    Sub client_SaveClickStats(RC As Boolean)
        If RC Then
            If Not RC Then
                LOG.WriteToSqlLog("ERROR client_SaveClickStats: Failed to update.")
            End If
        Else
            LOG.WriteToSqlLog("ERROR 100 client_SaveClickStats: ")
        End If
        ''RemoveHandler ProxySearch.SaveClickStatsCompleted, AddressOf client_SaveClickStats
    End Sub
    Public Sub RecordGrowth()
        Dim RC As Boolean = False

        'AddHandler ProxySearch.RecordGrowthCompleted, AddressOf client_RecordGrowth
        'EP.setSearchSvcEndPoint(proxy)
        ProxySearch.RecordGrowth(gSecureID, RC)
        client_RecordGrowth(RC)
    End Sub
    Sub client_RecordGrowth(RC As Boolean)
        If RC Then
            If Not RC Then
                LOG.WriteToSqlLog("ERROR client_RecordGrowth: Failed to update the associated DB Growthss.")
            End If
        Else
            LOG.WriteToSqlLog("ERROR 100 client_RecordGrowth: Failed to update the associated DB Growth.")
        End If
        ''RemoveHandler ProxySearch.RecordGrowthCompleted, AddressOf client_RecordGrowth
    End Sub

    Public Sub resetMissingEmailIds()
        Dim RC As Boolean = False

        'AddHandler ProxySearch.resetMissingEmailIdsCompleted, AddressOf client_resetMissingEmailIds
        'EP.setSearchSvcEndPoint(proxy)
        ProxySearch.resetMissingEmailIds(gSecureID, gCurrUserGuidID, RC)
        client_resetMissingEmailIds(RC)
    End Sub
    Sub client_resetMissingEmailIds(RC As Boolean)
        If RC Then
            If Not RC Then
                LOG.WriteToSqlLog("ERROR client_resetMissingEmailIds: Failed to update the associated record(s).")
            End If
        Else
            LOG.WriteToSqlLog("ERROR 100 client_resetMissingEmailIds: Failed to update the associated  record(s).")
        End If
        ''RemoveHandler ProxySearch.resetMissingEmailIdsCompleted, AddressOf client_resetMissingEmailIds
    End Sub

End Class
