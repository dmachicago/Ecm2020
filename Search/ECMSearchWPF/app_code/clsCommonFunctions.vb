' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="clsCommonFunctions.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
''' <summary>
''' Class clsCommonFunctions.
''' </summary>
Public Class clsCommonFunctions


    'Dim proxy As New SVCSearch.Service1Client
    ''' <summary>
    ''' The log
    ''' </summary>
    Dim LOG As New clsLogMain
    ''' <summary>
    ''' The g secure identifier
    ''' </summary>
    Dim gSecureID As String
    'Dim EP As New clsEndPoint

    ''' <summary>
    ''' Removes the single quotes.
    ''' </summary>
    ''' <param name="tVal">The t value.</param>
    Sub RemoveSingleQuotes(ByRef tVal As String)
        tVal = tVal.Replace("''", "'")
        tVal = tVal.Replace("'", "''")
    End Sub

    ''' <summary>
    ''' Initializes a new instance of the <see cref="clsCommonFunctions"/> class.
    ''' </summary>
    Sub New()
        gSecureID = _SecureID
    End Sub

    ''' <summary>
    ''' Saves the click.
    ''' </summary>
    ''' <param name="ID">The identifier.</param>
    ''' <param name="UID">The uid.</param>
    Public Sub SaveClick(ByVal ID As Integer, ByVal UID As String)
        Dim RC As Boolean = True
        'AddHandler ProxySearch.SaveClickStatsCompleted, AddressOf client_SaveClickStats
        'EP.setSearchSvcEndPoint(proxy)
        ProxySearch.SaveClickStats(_SecureID, ID, UID, RC)
        client_SaveClickStats(RC)
    End Sub

    ''' <summary>
    ''' Clients the save click stats.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
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
    ''' <summary>
    ''' Records the growth.
    ''' </summary>
    Public Sub RecordGrowth()
        Dim RC As Boolean = False

        'AddHandler ProxySearch.RecordGrowthCompleted, AddressOf client_RecordGrowth
        'EP.setSearchSvcEndPoint(proxy)
        ProxySearch.RecordGrowth(gSecureID, RC)
        client_RecordGrowth(RC)
    End Sub
    ''' <summary>
    ''' Clients the record growth.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
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

    ''' <summary>
    ''' Resets the missing email ids.
    ''' </summary>
    Public Sub resetMissingEmailIds()
        Dim RC As Boolean = False

        'AddHandler ProxySearch.resetMissingEmailIdsCompleted, AddressOf client_resetMissingEmailIds
        'EP.setSearchSvcEndPoint(proxy)
        ProxySearch.resetMissingEmailIds(gSecureID, gCurrUserGuidID, RC)
        client_resetMissingEmailIds(RC)
    End Sub
    ''' <summary>
    ''' Clients the reset missing email ids.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
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
