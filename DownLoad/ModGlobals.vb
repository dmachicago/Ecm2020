Imports System
Imports System.Text.RegularExpressions
Imports System.IO
Imports System.Net
Imports System.Text
Imports System.ServiceModel.Channels
Imports System.ServiceModel.EndpointAddress

Module ModGlobals

    Dim LOG As New clsLogging
    '**ProxyDownload is in project EcmCloud.Search.WCF and file clsDatabase.vb
    'Public ProxyDownload = New SVCclcDownload.Service1Client

    Public ProxyDownload = New SVCclcDownload.Service1Client
    Public ProxyGateway = New SVC_Gateway.Service1Client

    Public gRepoID As String = ""
    Public gGatewayCS As String = ""
    Public gRepoCS As String = ""

    Public gCompanyID As String = ""
    Public gRepoCode As String = ""
    Public gSessionID As String
    Public gSecureID As Integer = -1
    Public gSystemCurrUserID As String

    Public gSVCFS_Endpoint As String = ""
    Public gSVCGateway_Endpoint As String = ""
    Public gSVCCLCArchive_Endpoint As String = ""
    Public gSVCSearch_Endpoint As String = ""
    Public gSVCDownload_Endpoint As String = ""

    Public gCurrentUserID As String = ""
    Public gActiveRestorePath As String = ""
    Public gActivePreviewPath As String = ""
    Public gSearchActive As Boolean = False

    Public gUseEncrypted As Boolean = False
    Public gContractID As String = ""
    Public gLocalDebug As Boolean = False
    Public gSearchEndPoint As String = ""

    Public gUseConfigEndpoints As Boolean = False

    Public gEncCS As String = ""
    Public gCLCDIR As String = ""
    Public gDownloadDIR As String = ""
    Public gUserID As String = ""
    Public gCurrState As String = ""
    Public gGatewayEndPoint As String = ""
    Public gDownloadEndPoint As String = ""
    Public gENCGWCS As String = ""

    Public Function setGatewayEndpoints(CompanyID As String, RepoID As String, SecureEndPoint As String, DownloadEndPoint As String) As Boolean

        'gGatewayCS = setGatewayCs()
        'gRepoCS = setRepoCs()

        If CompanyID.Length <= 0 Then
            Return False
        End If
        If RepoID.Length <= 0 Then
            Return False
        End If

        If gUseConfigEndpoints = True Then
            LOG.WriteLog("ProxyGateway.Endpoint: LOCAL DEBUG")
            LOG.WriteLog("ProxyGateway.Endpoint: " + ProxyGateway.Endpoint.Address.ToString)
            LOG.WriteLog("ProxyDownload.Endpoint: " + ProxyDownload.Endpoint.Address.ToString)
            gGatewayEndPoint = ProxyGateway.Endpoint.Address.ToString
            gDownloadEndPoint = ProxyDownload.Endpoint.Address.ToString
            Return True
        End If

        If DownloadEndPoint.Length > 0 And SecureEndPoint.Length > 0 Then
            If gUseConfigEndpoints = False Then
                'SecureEndPoint = "http://97.76.174.190/SecureAttachAdminSvc/SVCGateway.svc"
                Dim GWBinding As System.ServiceModel.BasicHttpBinding = New System.ServiceModel.BasicHttpBinding()
                Dim endpoint As System.ServiceModel.EndpointAddress = New System.ServiceModel.EndpointAddress(New Uri(SecureEndPoint))
                'Dim httpBinding As System.ServiceModel.BasicHttpBinding = New System.ServiceModel.BasicHttpBinding()
                GWBinding.MaxReceivedMessageSize = 2147483647
                GWBinding.MaxBufferSize = 2147483647
                ProxyGateway = New SVC_Gateway.Service1Client(GWBinding, endpoint)

                Dim DLBinding As System.ServiceModel.BasicHttpBinding = New System.ServiceModel.BasicHttpBinding()
                Dim DLEndpoint As System.ServiceModel.EndpointAddress = New System.ServiceModel.EndpointAddress(New Uri(DownloadEndPoint))
                DLBinding.MaxReceivedMessageSize = 2147483647
                DLBinding.MaxBufferSize = 2147483647
                ProxyDownload = New SVCclcDownload.Service1Client(DLBinding, DLEndpoint)



                LOG.WriteLog("ProxyGateway.Endpoint: " + SecureEndPoint)
                LOG.WriteLog("ProxyDownload.Endpoint: " + DownloadEndPoint)
                Return True
            End If
        End If

        If (ProxyGateway Is Nothing) Then
            ProxyGateway = New SVC_Gateway.Service1Client()     'project: EcmSecureAttachWCF2
        End If
        If DownloadEndPoint.Length > 0 Then
            ProxyDownload.Endpoint.Address = New System.ServiceModel.EndpointAddress(DownloadEndPoint)
        End If
        If SecureEndPoint.Length > 0 Then
            gSVCGateway_Endpoint = SecureEndPoint
        ElseIf (gSVCCLCArchive_Endpoint.Length = 0) Then
            Dim endPoints As String = ProxyGateway.GetEndpoints(CompanyID, RepoID)
            Dim epoint() As String = endPoints.Split("|")

            gSVCFS_Endpoint = epoint(0)
            gSVCGateway_Endpoint = epoint(1)
            gSVCCLCArchive_Endpoint = epoint(2)
            gSVCSearch_Endpoint = epoint(3)
            gSVCDownload_Endpoint = epoint(4)
        End If

        If (ProxyDownload Is Nothing) Then
            ProxyDownload = New SVCclcDownload.Service1Client
            If (gSVCDownload_Endpoint.Length > 0) Then
                ProxyDownload.Endpoint.Address = New System.ServiceModel.EndpointAddress(gSVCDownload_Endpoint)
            End If
        Else
            If (gSVCDownload_Endpoint.Length > 0) Then
                ProxyDownload.Endpoint.Address = New System.ServiceModel.EndpointAddress(gSVCDownload_Endpoint)
            End If
        End If

        If (ProxyGateway Is Nothing) Then
            ProxyGateway = New SVC_Gateway.Service1Client
            If (SecureEndPoint.Length > 0) Then
                ProxyGateway.Endpoint.Address = New System.ServiceModel.EndpointAddress(SecureEndPoint)
            End If
        Else
            If (SecureEndPoint.Length > 0) Then
                ProxyGateway.Endpoint.Address = New System.ServiceModel.EndpointAddress(SecureEndPoint)
            End If
        End If
        LOG.WriteLog("Gateway Endpoint: " + SecureEndPoint)
        Return True
    End Function

    ''' <summary>
    ''' Reads the global data.
    ''' This file is written by the ARCHIVER and allows the DOWNLOADER to read the endpoints being used by the ARCHIVER.
    ''' </summary>
    Public Sub readGlobalData()
        Dim vars As String = ""
        Try
            Dim filePath As String
            filePath = System.IO.Path.Combine(
                       My.Computer.FileSystem.SpecialDirectories.MyDocuments, "gVars.txt")

            If (File.Exists(filePath)) Then
                vars = My.Computer.FileSystem.ReadAllText(filePath).ToString

                Dim epoint() As String = vars.Split("|")

                gCompanyID = epoint(0)
                gRepoCode = epoint(1)
                gSVCFS_Endpoint = epoint(2)
                gSVCGateway_Endpoint = epoint(3)
                gSVCCLCArchive_Endpoint = epoint(4)
                gSVCSearch_Endpoint = epoint(5)
                gSVCDownload_Endpoint = epoint(6)
            End If

        Catch fileException As Exception
            Throw fileException
        End Try

        If (gSVCDownload_Endpoint.Length > 0) Then
            ProxyDownload.Endpoint.Address = New System.ServiceModel.EndpointAddress(gSVCDownload_Endpoint)
        End If

    End Sub

End Module
