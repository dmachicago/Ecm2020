' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="clsPullDatasource.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
Imports System.Data
Imports System.Data.SqlClient

''' <summary>
''' Class clsPullDataItem.
''' </summary>
Public Class clsPullDataItem

    ''' <summary>
    ''' The database
    ''' </summary>
    Dim DB As New clsDatabase

    ''' <summary>
    ''' Pulls the email item.
    ''' </summary>
    ''' <param name="ColumnName">Name of the column.</param>
    ''' <param name="EmailGuid">The email unique identifier.</param>
    ''' <returns>System.String.</returns>
    Function PullEmailItem(ColumnName As String, EmailGuid As String) As String
        Dim MySql As String = "select " + ColumnName + " from Email where SourceGuid = '" + EmailGuid + "'"
        Dim tval As String = ""
        Dim CS As String = DB.getRepoCs()
        Dim CONN As New SqlConnection(CS)
        CONN.Open()

        Dim RSData As SqlDataReader = Nothing
        Dim command As New SqlCommand(MySql, CONN)

        RSData = command.ExecuteReader()
        Try
            If RSData.HasRows Then
                RSData.Read()
                tval = RSData.GetValue(0).ToString()
            End If
        Catch ex As Exception
            Console.WriteLine("ERROR pull_RowGuid-00B1: " + ex.Message)
            tval = ""
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

        Return tval
    End Function

    ''' <summary>
    ''' Pulls the datasource item.
    ''' </summary>
    ''' <param name="ColumnName">Name of the column.</param>
    ''' <param name="SourceGuid">The source unique identifier.</param>
    ''' <returns>System.String.</returns>
    Function PullDatasourceItem(ColumnName As String, SourceGuid As String) As String

        Dim MySql As String = "select " + ColumnName + " from DataSource where SourceGuid = '" + SourceGuid + "'"
        Dim tval As String = ""
        Dim CS As String = DB.getRepoCs()
        Dim CONN As New SqlConnection(CS)
        CONN.Open()

        Dim RSData As SqlDataReader = Nothing
        Dim command As New SqlCommand(MySql, CONN)

        RSData = command.ExecuteReader()
        Try
            If RSData.HasRows Then
                RSData.Read()
                tval = RSData.GetValue(0).ToString()
            End If
        Catch ex As Exception
            Console.WriteLine("ERROR pull_RowGuid-00A1: " + ex.Message)
            tval = ""
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

        Return tval
    End Function

End Class