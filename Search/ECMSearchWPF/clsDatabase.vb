' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 07-16-2020
'
' Last Modified By : wdale
' Last Modified On : 07-16-2020
' ***********************************************************************
' <copyright file="clsDatabase.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
Imports System.Data
Imports System.Data.SqlClient
Imports System.Data.Sql
Imports System.IO
Imports System.Collections
Imports System.Collections.Generic
Imports System.IO.Compression
Imports ECMEncryption

''' <summary>
''' Class clsDatabase.
''' </summary>
Public Class clsDatabase

    ''' <summary>
    ''' The enc
    ''' </summary>
    Dim ENC As New ECMEncrypt
    'Dim ENC2 As New clsEncrypt

    ''' <summary>
    ''' Gets the gateway cs.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getGatewayCs() As String
        gCSGateWay = getGatewayCs()
        Return gCSGateWay
    End Function

    ''' <summary>
    ''' Gets the cs gateway.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getCSGateway() As String


        Dim CS As String = System.Configuration.ConfigurationManager.AppSettings("ECMSecureLogin")
        'Dim TS As String = XXI()
        Dim TS As String = System.Configuration.ConfigurationManager.AppSettings("EncPW")
        TS = ENC.AES256DecryptString(TS)

        If (CS = Nothing) Then
            CS = ""
        Else
            CS = CS.Replace("@@PW@@", TS)
        End If
        Return CS

    End Function


    ''' <summary>
    ''' Gets the repo cs.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getRepoCs() As String
        gCSRepo = gFetchCS()
        Return gCSRepo
    End Function

    ''' <summary>
    ''' Sets the repo cs.
    ''' </summary>
    ''' <param name="RowID">The row identifier.</param>
    ''' <returns>System.String.</returns>
    Private Function setRepoCS(RowID As Integer) As String
        Dim RepoCS As String = gFetchCS()
        Return RepoCS
    End Function


    ''' <summary>
    ''' Gets the endpoint.
    ''' </summary>
    ''' <param name="RowID">The row identifier.</param>
    Public Sub getEndpoint(RowID As String)


        Dim CS As String = getGatewayCs()
        Dim S As String = ""

        S += " Select " + vbCrLf
        S += " SVCGateway_Endpoint" + vbCrLf
        S += " ,SVCSearch_Endpoint" + vbCrLf
        S += " ,SVCDownload_Endpoint" + vbCrLf
        S += " FROM SecureAttach"
        S += " Where RowID = " + RowID

        If gDebug.Equals(True) Then
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

    'Public Function setEndpoints() As Boolean

    '    Dim B As Boolean = True
    '    Try

    '        If (ProxyGateway Is Nothing) Then
    '            ProxyGateway = New SVCGateway.Service1Client()
    '        End If
    '        ProxyGateway.Endpoint.Address = New System.ServiceModel.EndpointAddress(gSVCGateway_Endpoint)

    '        If (gSVCSearch_Endpoint.Length > 0) Then
    '            ProxySearch = New SVCSearch.Service1Client()
    '        End If
    '        ProxySearch.Endpoint.Address = New System.ServiceModel.EndpointAddress(gSVCSearch_Endpoint)

    '    Catch ex As Exception
    '        MessageBox.Show("ERROR 223: Failed to set endpoints - " + ex.Message)
    '        B = False
    '    End Try

    '    Return B

    'End Function

End Class

