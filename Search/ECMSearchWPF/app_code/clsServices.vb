' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="clsServices.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
''' <summary>
''' Class clsgetUserParm.
''' </summary>
Public Class clsgetUserParm


    ''' <summary>
    ''' The t value
    ''' </summary>
    Public tVal As String = ""
    ''' <summary>
    ''' The g secure identifier
    ''' </summary>
    Dim gSecureID As String = -1

    'Dim EP As New clsEndPoint

    'Dim proxy As New SVCSearch.Service1Client

    ''' <summary>
    ''' Initializes a new instance of the <see cref="clsgetUserParm"/> class.
    ''' </summary>
    Sub New()
        gSecureID = _SecureID
    End Sub
    ''' <summary>
    ''' Gets or sets the t variable.
    ''' </summary>
    ''' <value>The t variable.</value>
    Public Property tVar() As String
        Get
            Return tVal
        End Get
        Set(ByVal value As String)
            tVal = value
        End Set
    End Property ' Hour

    ''' <summary>
    ''' Gets the user variable.
    ''' </summary>
    ''' <param name="VariableID">The variable identifier.</param>
    ''' <param name="ReturnedValue">The returned value.</param>
    Sub getUserVar(ByVal VariableID As String, ByRef ReturnedValue As String)
        '"user_MaxRecordsToFetch"

        'AddHandler ProxySearch.getUserParmCompleted, AddressOf client_getUserParm
        'EP.setSearchSvcEndPoint(proxy)
        ProxySearch.getUserParm(gSecureID, VariableID, ReturnedValue)
        client_getUserParm(VariableID)
    End Sub

    ''' <summary>
    ''' Clients the get user parm.
    ''' </summary>
    ''' <param name="VariableID">The variable identifier.</param>
    Sub client_getUserParm(VariableID As String)
        If VariableID.Length > 0 Then
            tVal = VariableID
        Else
            tVal = ""
        End If
        'RemoveHandler ProxySearch.getUserParmCompleted, AddressOf client_getUserParm
    End Sub
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

