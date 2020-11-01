Imports Microsoft.SqlServer.Management.Smo

Public Class clsSmo

    Dim DMA As New clsDma
    Dim LOG As New clsLogging
    Dim UTIL As New clsUtility


    'Public Sub smoLoadDatabases(ByVal ServerName , ByRef CB As Windows.Forms.ComboBox)

    '    Dim FoundDatabases As Boolean = False
    '    Dim i As Integer = 0
    '    CB.Items.Clear()
    '    Try
    '        Dim srv As New Server(ServerName)
    '        Dim DBARCH As Database
    '        For Each DBARCH In srv.Databases
    '            FoundDatabases = True
    '            'Trace.WriteLine(DBARCH.Name)
    '            'Trace.Indent()
    '            CB.Items.Add(DBARCH.Name)
    '            For Each tbl As Table In DBARCH.Tables
    '                Trace.WriteLine(tbl.Name)
    '            Next
    '            Trace.Unindent()
    '        Next
    '    Catch ex As Exception
    '        CB.Items.Clear()
    '        CB.Items.Add(ex.Message.Trim)
    '        log.WriteToArchiveLog("clsDma : smoLoadDatabases : 777 : " + ex.Message)
    '        log.WriteToArchiveLog("clsDma : smoLoadDatabases : 799 : " + ex.Message)
    '        log.WriteToArchiveLog("clsDma : smoLoadDatabases : 814 : " + ex.Message)
    '    End Try
    '    If FoundDatabases = False Then
    '        CB.Items.Add("FOUND NONE")
    '    End If
    'End Sub

    'Public Sub smoLoadDatabaseTables(ByVal ServerName , ByVal DatabaseName , ByVal UserID , ByVal PW , ByRef CB As Windows.Forms.ComboBox)

    '    Dim FoundDatabases As Boolean = False
    '    Dim i As Integer = 0
    '    CB.Items.Clear()
    '    Try
    '        Dim srv As New Server(".")
    '        Dim DBARCH As Database
    '        For Each DBARCH In srv.Databases
    '            FoundDatabases = True
    '            'Trace.WriteLine(DBARCH.Name)
    '            'Trace.Indent()
    '            If DBARCH.Name.Equals(DatabaseName ) Then
    '                For Each tbl As Table In DBARCH.Tables
    '                    Trace.WriteLine(tbl.Name)
    '                    CB.Items.Add(tbl.Name)
    '                Next
    '            End If
    '            'Trace.Unindent()
    '        Next
    '    Catch ex As Exception
    '        CB.Items.Clear()
    '        CB.Items.Add(ex.Message.Trim)
    '        log.WriteToArchiveLog("clsDma : smoLoadDatabaseTables : 797 : " + ex.Message)
    '        log.WriteToArchiveLog("clsDma : smoLoadDatabaseTables : 820 : " + ex.Message)
    '        log.WriteToArchiveLog("clsDma : smoLoadDatabaseTables : 836 : " + ex.Message)
    '    End Try
    '    If FoundDatabases = False Then
    '        CB.Items.Add("FOUND NONE")
    '    End If
    'End Sub
End Class
