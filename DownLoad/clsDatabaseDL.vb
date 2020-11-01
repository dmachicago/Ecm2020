Imports System.Data
Imports System.Data.SqlClient
Imports System.Data.Sql
Imports System.IO
Imports System.Collections
Imports System.Collections.Generic
Imports System.IO.Compression

Public Class clsDatabaseDL
    Inherits clsEncrypt

    Public Function getGatewayCs() As String
        gGatewayCS = getCSGateway()
        Return gGatewayCS
    End Function


    Public Function getRepoCs(RowID As Integer) As String
        If gRepoCS.Length() > 0 Then
            Return gRepoCS
        End If
        gRepoCS = setRepoCS(RowID)
        Return gRepoCS
    End Function

    Private Function setRepoCS(RowID As Integer) As String

        Dim CS As String = getGatewayCs()
        Dim S As String = ""
        Dim RepoCS As String = ""

        S += " Select CSRepo from [SecureAttach] Where RowID = " + RowID.ToString()

        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection(CS)
        CONN.Open()
        Dim command As New SqlCommand(S, CONN)

        RSData = command.ExecuteReader()

        Try
            If RSData.HasRows Then
                RSData.Read()
                RepoCS = RSData.GetValue(0).ToString()
                RepoCS = DecryptTripleDES(RepoCS)
            End If
        Catch ex As Exception
            Console.WriteLine("ERROR 00A1: " + ex.Message)
            RepoCS = ""
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return RepoCS

    End Function


    Public Sub getEndpoint(RowID As String)


        Dim CS As String = getGatewayCs()
        Dim S As String = ""

        S += " Select " + vbCrLf
        S += " SVCGateway_Endpoint" + vbCrLf
        S += " ,SVCSearch_Endpoint" + vbCrLf
        S += " ,SVCDownload_Endpoint" + vbCrLf
        S += " FROM SecureAttach"
        S += " Where RowID = " + RowID

        Dim ddebug As Boolean = False
        If ddebug.Equals(True) Then
            Debug.Print("01x SQL: " + vbCrLf + S)
        End If
        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection(CS)
        CONN.Open()
        Dim command As New SqlCommand(S, CONN)

        RSData = command.ExecuteReader()

        Try
            If RSData.HasRows Then
                RSData.Read()
                gSVCGateway_Endpoint = RSData.GetString(0)
                gSVCSearch_Endpoint = RSData.GetString(1)
                gSVCDownload_Endpoint = RSData.GetString(2)


                Debug.Print("gSVCGateway_Endpoint: " + gSVCGateway_Endpoint)
                Debug.Print("gSVCSearch_Endpoint: " + gSVCSearch_Endpoint)
                Debug.Print("gSVCDownload_Endpoint: " + gSVCDownload_Endpoint)


            End If
        Catch ex As Exception
            Console.WriteLine("ERROR 00A1: " + ex.Message)
            CS = ""
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

    End Sub

    Public Function setEndpoints() As Boolean

        Dim B As Boolean = True
        Try

            If (ProxyGateway Is Nothing) Then
                ProxyGateway = New SVC_Gateway.Service1Client()
            End If
            ProxyGateway.Endpoint.Address = New System.ServiceModel.EndpointAddress(gSVCGateway_Endpoint)

            If (gSVCDownload_Endpoint.Length > 0) Then
                ProxyDownload = New SVCclcDownload.Service1Client()
            End If
            ProxyDownload.Endpoint.Address = New System.ServiceModel.EndpointAddress(gSVCDownload_Endpoint)

        Catch ex As Exception
            MessageBox.Show("ERROR 223: Failed to set endpoints - " + ex.Message)
            B = False
        End Try

        Return B

    End Function

End Class
