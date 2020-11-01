Imports System.Data
Imports System.Data.SqlClient

Public Class clsPullDataItem

    Dim DB As New clsDatabase

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