Imports System.Configuration
Imports System.Data.SqlClient
Imports System.Data.SqlServerCe
Imports System.IO
Imports ECMEncryption
'Imports Microsoft.Data.Sqlite
Imports System.Data.SQLite


Public Class frmSqlite

    Dim LOG As New clsLogging
    Public cs As String = ""
    Public SLiteConn As New SqliteConnection()
    Dim SQLiteDB As New clsDbLocal

    Dim UseDebugSQLite As Integer = System.Configuration.ConfigurationManager.AppSettings("UseDebugSQLite")

    Private Function getCs() As String
        Dim strPath As String = ""
        Dim connstr As String = ""

        slDatabase = System.Configuration.ConfigurationManager.AppSettings("SQLiteLocalDB")
        connstr = "data source=" + slDatabase

        lblConn.Text = connstr
        Return connstr
    End Function

    Private Sub btnExec_Click(sender As Object, e As EventArgs) Handles btnExec.Click

        SQLiteDB.setSLConn()

        Dim S As String = txtSql.Text

        Dim CMD As New SQLite.SQLiteCommand
        Try
            CMD.ExecuteNonQuery()
            MessageBox.Show("SUCCESSFUL EXecution")
        Catch ex As Exception
            Dim msg As String = "ERROR: clsDbLocal/addInventory - " + Environment.NewLine + S + Environment.NewLine + ex.Message
            MessageBox.Show(msg)
            B = False
        Finally
            CMD.Dispose()
            'If cn IsNot Nothing Then
            '    If cn.State = ConnectionState.Open Then
            '        cn.Close()
            '    End If
            '    cn.Dispose()
            'End If
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

    End Sub

    Private Sub rbContactsArchive_CK(dg As DataGridView)
        setConn()
        Dim sql As String = "select * from ContactsArchive;"
        filleGrid(sql, dg)
    End Sub

    Private Sub filleGrid(SQL As String, ByRef dg As DataGridView)

        MessageBox.Show("Not available at this time... ")
        Return

        If txtLimit.Text.Trim.Length > 0 Then
            SQL = SQL.Replace(";", " ")
            SQL = SQL + " LIMIT " + txtLimit.Text + ";"
        End If

        setConn()

        Try
            'Dim ds As DataSet = New DataSet()
            'Dim cmdx As New SqliteCommand(sql, SQLiteCONN)
            'Dim da = New SQLiteDataAdapter(cmdx)
            'da.Fill(ds)
            'dg.DataSource = ds.Tables(0).DefaultView
            'SLiteConn.Close()
            'SLiteConn.Dispose()

        Catch ex As Exception
            MessageBox.Show(ex.Message)
        End Try
    End Sub


    Private Sub rbDirectory_CheckedChanged_CK(ByRef dg As DataGridView)
        setConn()
        Dim sql As String = "select * from Directory;"
        filleGrid(sql, dg)
    End Sub

    Private Sub rbExchange_CheckedChanged_CK(ByRef dg As DataGridView)
        setConn()
        Dim sql As String = "select * from Exchange;"
        filleGrid(sql, dg)

    End Sub

    Private Sub rbFiles_CheckedChanged_CK(ByRef dg As DataGridView)
        setConn()
        Dim sql As String = "select * from Files;"
        filleGrid(sql, dg)
    End Sub

    Private Sub rbInventory_CheckedChanged_CK(ByRef dg As DataGridView)
        setConn()
        Dim sql As String = "select * from Inventory;"
        filleGrid(sql, dg)
    End Sub

    Private Sub rbListener_CheckedChanged_CK(ByRef dg As DataGridView)
        setConn()
        Dim sql As String = "select * from Listener;"
        filleGrid(sql, dg)
    End Sub

    Private Sub rbMultiLocationFiles_CheckedChanged_CK(ByRef dg As DataGridView)
        setConn()
        Dim sql As String = "select * from MultiLocationFiles;"
        filleGrid(sql, dg)
    End Sub

    Private Sub rbOutlook_CheckedChanged_CK(ByRef dg As DataGridView)
        setConn()
        Dim sql As String = "select * from Outlook;"
        filleGrid(sql, dg)
    End Sub

    Public Sub rbZipFile_CheckedChanged_CK(ByRef dg As DataGridView)
        setConn()
        Dim sql As String = "select * from ZipFile;"
        filleGrid(sql, dg)
    End Sub

    Private Sub btnValidate_Click(sender As Object, e As EventArgs) Handles btnValidate.Click
        setConn()
        If CheckBox1.Checked Then
            rbContactsArchive_CK(dgData)
        End If
        If CheckBox2.Checked Then
            rbDirectory_CheckedChanged_CK(dgData)
        End If
        If CheckBox4.Checked Then
            rbExchange_CheckedChanged_CK(dgData)
        End If
        If CheckBox3.Checked Then
            rbFiles_CheckedChanged_CK(dgData)
        End If
        If CheckBox6.Checked Then
            rbListener_CheckedChanged_CK(dgData)
        End If
        If CheckBox5.Checked Then
            rbMultiLocationFiles_CheckedChanged_CK(dgData)
        End If
        If CheckBox8.Checked Then
            rbOutlook_CheckedChanged_CK(dgData)
        End If
        If CheckBox7.Checked Then
            rbZipFile_CheckedChanged_CK(dgData)
        End If

    End Sub

    Private Sub CheckBox1_CheckedChanged(sender As Object, e As EventArgs) Handles CheckBox1.CheckedChanged
        CheckBox2.Checked = False
        CheckBox3.Checked = False
        CheckBox4.Checked = False
        CheckBox5.Checked = False
        CheckBox6.Checked = False
        CheckBox7.Checked = False
        CheckBox8.Checked = False
        'CheckBox1.Checked = True
    End Sub

    Private Sub CheckBox2_CheckedChanged(sender As Object, e As EventArgs) Handles CheckBox2.CheckedChanged
        CheckBox1.Checked = False
        CheckBox3.Checked = False
        CheckBox4.Checked = False
        CheckBox5.Checked = False
        CheckBox6.Checked = False
        CheckBox7.Checked = False
        CheckBox8.Checked = False

        Dim i As Integer = 0
        SQLiteDB.setSLConn()

        Dim sql As String = ""
        If txtLimit.Text.Length = 0 Or txtLimit.Text.Trim.Equals("0") Then
            sql = "SELECT * FROM Directory order by DirName "
        Else
            sql = "SELECT * FROM Directory order by DirName LIMIT " + txtLimit.Text.Trim
        End If

        dgData.Columns.Clear()
        dgData.Rows.Clear()
        dgData.Columns.Add("DirName", "DirName")
        dgData.Columns.Add("DirID", "DirID")
        dgData.Columns.Add("UseArchiveBit", "UseArchiveBit")
        dgData.Columns.Add("DirHash", "DirHash")

        Dim DirName As String = ""
        Dim DirID As String = ""
        Dim UseArchiveBit As String = ""
        Dim DirHash As String = ""

        Try
            SQLiteDB.SQLiteCONN.Open()
        Catch ex As Exception
            Console.WriteLine("XX991: " + ex.Message)
        End Try

        Using SQLiteDB.SQLiteCONN
            Using CMD As New SqliteCommand(sql, SQLiteDB.SQLiteCONN)
                Dim rdr As SqliteDataReader = CMD.ExecuteReader()
                Using rdr
                    While (rdr.Read())
                        DirName = rdr.GetValue(0).ToString
                        DirID = rdr.GetValue(1).ToString
                        UseArchiveBit = rdr.GetValue(2).ToString
                        DirHash = rdr.GetValue(3).ToString

                        Dim RowIndex As Integer = dgData.Rows.Add()
                        Dim NewRow As DataGridViewRow = dgData.Rows(RowIndex)
                        NewRow.Cells(0).Value = DirName
                        NewRow.Cells(1).Value = DirID
                        NewRow.Cells(2).Value = UseArchiveBit
                        NewRow.Cells(3).Value = DirHash
                    End While
                End Using
            End Using
        End Using

    End Sub

    Private Sub CheckBox4_CheckedChanged(sender As Object, e As EventArgs) Handles CheckBox4.CheckedChanged
        'CheckBox4.Checked = True
        CheckBox1.Checked = False
        CheckBox2.Checked = False
        CheckBox3.Checked = False
        CheckBox5.Checked = False
        CheckBox6.Checked = False
        CheckBox7.Checked = False
        CheckBox8.Checked = False
    End Sub

    Private Sub CheckBox3_CheckedChanged(sender As Object, e As EventArgs) Handles CheckBox3.CheckedChanged
        CheckBox1.Checked = False
        CheckBox2.Checked = False
        CheckBox4.Checked = False
        CheckBox5.Checked = False
        CheckBox6.Checked = False
        CheckBox7.Checked = False
        CheckBox8.Checked = False
        'CheckBox3.Checked = True

        Dim i As Integer = 0
        SQLiteDB.setSLConn()

        Dim sql As String = ""
        If txtLimit.Text.Length = 0 Or txtLimit.Text.Trim.Equals("0") Then
            sql = "SELECT * FROM Directory order by FileID "
        Else
            sql = "SELECT * FROM Directory order by FileID LIMIT " + txtLimit.Text.Trim
        End If

        dgData.Columns.Clear()
        dgData.Rows.Clear()
        dgData.Columns.Add("FileID", "FileID")
        dgData.Columns.Add("FileName", "FileName")
        dgData.Columns.Add("FileHash", "FileHash")

        Dim FileID As String = ""
        Dim FileName As String = ""
        Dim FileHash As String = ""

        Try
            SQLiteDB.SQLiteCONN.Open()
        Catch ex As Exception
            Console.WriteLine("XX991: " + ex.Message)
        End Try

        Using SQLiteDB.SQLiteCONN
            Using CMD As New SqliteCommand(sql, SQLiteDB.SQLiteCONN)
                Dim rdr As SqliteDataReader = CMD.ExecuteReader()
                Using rdr
                    While (rdr.Read())
                        FileID = rdr.GetValue(0).ToString
                        FileName = rdr.GetValue(1).ToString
                        FileHash = rdr.GetValue(2).ToString

                        Dim RowIndex As Integer = dgData.Rows.Add()
                        Dim NewRow As DataGridViewRow = dgData.Rows(RowIndex)
                        NewRow.Cells(0).Value = FileID
                        NewRow.Cells(1).Value = FileName
                        NewRow.Cells(2).Value = FileHash
                    End While
                End Using
            End Using
        End Using

    End Sub

    Private Sub CheckBox6_CheckedChanged(sender As Object, e As EventArgs) Handles CheckBox6.CheckedChanged
        CheckBox1.Checked = False
        CheckBox2.Checked = False
        CheckBox3.Checked = False
        CheckBox4.Checked = False
        CheckBox5.Checked = False
        'CheckBox6.Checked = True
        CheckBox7.Checked = False
        CheckBox8.Checked = False
    End Sub

    Private Sub CheckBox5_CheckedChanged(sender As Object, e As EventArgs) Handles CheckBox5.CheckedChanged
        CheckBox1.Checked = False
        CheckBox2.Checked = False
        CheckBox3.Checked = False
        CheckBox4.Checked = False
        'CheckBox5.Checked = True
        CheckBox6.Checked = False
        CheckBox7.Checked = False
        CheckBox8.Checked = False
    End Sub

    Private Sub CheckBox8_CheckedChanged(sender As Object, e As EventArgs) Handles CheckBox8.CheckedChanged
        CheckBox1.Checked = False
        CheckBox2.Checked = False
        CheckBox3.Checked = False
        CheckBox4.Checked = False
        CheckBox5.Checked = False
        CheckBox6.Checked = False
        CheckBox7.Checked = False
        'CheckBox8.Checked = True
    End Sub

    Private Sub CheckBox7_CheckedChanged(sender As Object, e As EventArgs) Handles CheckBox7.CheckedChanged
        CheckBox1.Checked = False
        CheckBox2.Checked = False
        CheckBox3.Checked = False
        CheckBox4.Checked = False
        CheckBox5.Checked = False
        CheckBox6.Checked = False
        'CheckBox7.Checked = True
        CheckBox8.Checked = False
    End Sub

    Public Function setConn() As Boolean

        Dim bb As Boolean = True

        If Not SLiteConn.State.Equals(SLiteConn.State.Open) Then
            Try
                Dim slDatabase As String = System.Configuration.ConfigurationManager.AppSettings("SQLiteLocalDB")
                cs = "data source=" + slDatabase

                SQLiteDB.SQLiteCONN.ConnectionString = cs
                SQLiteDB.SQLiteCONN.Open()
                bb = True
                bSLConn = True
            Catch ex As Exception
                bb = False
                bSLConn = False
            End Try
        End If
        Return bb
    End Function

    Private Sub RadioButton1_CheckedChanged(sender As Object, e As EventArgs) Handles RadioButton1.CheckedChanged
        Dim tbl As String = "ContactsArchive"
        Dim s As String = getCount(tbl)
        MessageBox.Show(tbl + " : " + s)
    End Sub

    Function getCount(tbl As String) As String

        Dim i As Integer = 0
        SQLiteDB.setSLConn()

        Using SQLiteDB.SQLiteCONN
            Dim sql As String = "SELECT count(*) FROM " + tbl
            Using CMD As New SqliteCommand(sql, SQLiteDB.SQLiteCONN)
                Dim rdr As SqliteDataReader = CMD.ExecuteReader()
                Using rdr
                    While (rdr.Read())
                        i = rdr.GetInt32(0)
                    End While
                End Using
            End Using
        End Using
        Return i.ToString
    End Function

    Private Sub RadioButton3_CheckedChanged(sender As Object, e As EventArgs) Handles RadioButton3.CheckedChanged
        Dim tbl As String = "Directory"
        Dim s As String = getCount(tbl)
        MessageBox.Show(tbl + " : " + s)
    End Sub

    Private Sub RadioButton2_CheckedChanged(sender As Object, e As EventArgs) Handles RadioButton2.CheckedChanged
        Dim tbl As String = "Exchange"
        Dim s As String = getCount(tbl)
        MessageBox.Show(tbl + " : " + s)
    End Sub

    Private Sub RadioButton6_CheckedChanged(sender As Object, e As EventArgs) Handles RadioButton6.CheckedChanged
        Dim tbl As String = "Files"
        Dim s As String = getCount(tbl)
        MessageBox.Show(tbl + " : " + s)
    End Sub

    Private Sub RadioButton4_CheckedChanged(sender As Object, e As EventArgs) Handles RadioButton4.CheckedChanged
        Dim tbl As String = "Listener"
        Dim s As String = getCount(tbl)
        MessageBox.Show(tbl + " : " + s)
    End Sub

    Private Sub RadioButton5_CheckedChanged(sender As Object, e As EventArgs) Handles RadioButton5.CheckedChanged
        Dim tbl As String = "MultiLocationFiles"
        Dim s As String = getCount(tbl)
        MessageBox.Show(tbl + " : " + s)
    End Sub

    Private Sub RadioButton7_CheckedChanged(sender As Object, e As EventArgs) Handles RadioButton7.CheckedChanged
        Dim tbl As String = "Outlook"
        Dim s As String = getCount(tbl)
        MessageBox.Show(tbl + " : " + s)
    End Sub

    Private Sub RadioButton8_CheckedChanged(sender As Object, e As EventArgs) Handles RadioButton8.CheckedChanged
        Dim tbl As String = "Zipfile"
        Dim s As String = getCount(tbl)
        MessageBox.Show(tbl + " : " + s)
    End Sub

    Private Sub dgData_CellContentClick(sender As Object, e As DataGridViewCellEventArgs) Handles dgData.CellContentClick

    End Sub
End Class