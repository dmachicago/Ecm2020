Imports System.Threading
Imports Microsoft.Win32
Imports System.IO
Imports System.Diagnostics.PerformanceCounter
Imports System.ServiceModel
Imports ECMEncryption

Public Class clsEndpoint

    Dim LOG As New clsLogging
    Dim ISO As New clsIsolatedStorage
    Dim ENC As new ECMEncrypt

    'Dim ProxyFS As New SVCFS.Service1Client

    Function setSVCFSEndpoint(baseAddress As String) As Boolean
        Dim b As Boolean = True

        'Specify a base address for the service
        If baseAddress = Nothing Then
            MessageBox.Show("ERROR 2201-a: SVCFS endpoint missing.")
            Return False
        End If

        ProxyFS.Endpoint.Address = New System.ServiceModel.EndpointAddress(baseAddress)
        'Create the binding to be used by the service.

        Dim binding1 As New BasicHttpBinding()

        'Create the host and call AddServiceEndpoint(Type, Binding, String) or one of the 
        'other overloads to add the service endpoint for the host.
        Dim SVCFS_host As New ServiceHost(GetType(SVCFS.Service1Client))
        SVCFS_host.AddServiceEndpoint(GetType(SVCFS.IService1), binding1, baseAddress)

        'http://msdn.microsoft.com/en-us/library/system.servicemodel.basichttpbinding(v=vs.110).aspx
        Dim modifiedCloseTimeout As New TimeSpan(0, 2, 0)
        binding1.CloseTimeout = modifiedCloseTimeout
        binding1.MaxBufferSize = 1000000
        binding1.MaxReceivedMessageSize = 2000000000

        ''To specify the binding in code, but to use the default endpoints provided 
        ''by the runtime, pass the base address into constructor when creating 
        ''the ServiceHost, and do not call AddServiceEndpoint.
        'SVCFS_host = New ServiceHost(GetType(SVCFS.Service1Client), New Uri(baseAddress))

        Return b
    End Function

End Class
