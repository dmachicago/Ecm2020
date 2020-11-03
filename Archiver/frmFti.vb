Imports System.IO

Public Class frmFti

    Dim DBArch As New clsDatabaseARCH

    Private Sub frmFti_Load(sender As Object, e As EventArgs) Handles MyBase.Load

        getFtiLogs()


    End Sub

    Sub getFtiLogs()

        Dim files() As String = IO.Directory.GetFiles(FTILogs)
        Dim FName As String = ""

        lbFtiLogs.Items.Clear()

        For Each file As String In files
            FName = Path.GetFileName(file)
            lbFtiLogs.Items.Add(FName)
            'Dim text As String = IO.File.ReadAllText(file)
        Next
    End Sub

    Private Sub btnSelectAll_Click(sender As Object, e As EventArgs) Handles btnSelectAll.Click

        Dim i As Integer
        For i = 0 To lbFtiLogs.Items.Count - 1
            lbFtiLogs.SetSelected(i, True)
        Next

    End Sub

    Private Sub btnScanGuids_Click(sender As Object, e As EventArgs) Handles btnScanGuids.Click

        lbOutput.Items.Clear()

        Dim FQN As String = ""
        Dim TgtText = txtSourceGuid.Text
        Dim I As Integer = 0
        Dim IFound As Integer = 0

        Dim MaxCnt As Integer = Convert.ToInt32(txtMaxNbr.Text)

        For Each S As String In lbFtiLogs.SelectedItems
            FQN = FTILogs + "\" + S
            Dim reader As StreamReader = My.Computer.FileSystem.OpenTextFileReader(FQN)
            Dim line As String
            SBFqn.Text = S
            Me.Cursor = Cursors.WaitCursor
            Do
                Application.DoEvents()
                I += 1
                If I >= MaxCnt Then
                    Exit Do
                End If
                If I Mod 100 = 0 Then
                    SB.Text = I.ToString
                    SB.Refresh()
                End If
                line = reader.ReadLine
                If Not IsNothing(line) Then
                    If line.Contains(TgtText) Then
                        lbOutput.Items.Add(line)
                        IFound += 1
                        lblMsg.Text = "Items Found: " + IFound.ToString
                    End If
                End If
            Loop Until line Is Nothing
            Me.Cursor = Cursors.Default
            reader.Close()
            reader.Dispose()
            SB.Text = ""
            SBFqn.Text = ""
        Next

    End Sub

    Private Sub lbFtiLogs_SelectedIndexChanged(sender As Object, e As EventArgs) Handles lbFtiLogs.SelectedIndexChanged

    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim key As String = "SQLFT0001200010.LOG.4"
        Dim lbkey As String = ""
        Dim i As Integer

        For i = 0 To lbFtiLogs.Items.Count - 1
            lbFtiLogs.SetSelected(i, False)
        Next

        For i = 0 To lbFtiLogs.Items.Count - 1
            lbkey = lbFtiLogs.Items(i)
            If lbkey = key Then
                lbFtiLogs.SetSelected(i, True)
            End If
        Next
    End Sub

    Private Sub lbOutput_SelectedIndexChanged(sender As Object, e As EventArgs) Handles lbOutput.SelectedIndexChanged
        Dim s As String = lbOutput.SelectedItems(0)
        txtDetail.Text = s

        Dim tkey As String = ""
        Dim db As String = ""
        Dim i As Integer = 0
        Dim k As Integer = 0

        Try
            i = s.IndexOf("view")
            If i >= 0 Then
                i = s.IndexOf("'", i + 1)
                j = s.IndexOf("'", i + 1)
                db = s.Substring(i + 1, j - i - 1)
                txtDb.Text = db
            End If

            i = s.IndexOf("key value")
            If i >= 0 Then
                i = s.IndexOf("'", i + 1)
                j = s.IndexOf("'", i + 1)
                tkey = s.Substring(i + 1, j - i - 1)
                txtKeyGuid.Text = tkey
            End If
        Catch ex As Exception
            SB.Text = "ERROR: " + ex.Message
        End Try




    End Sub

    Private Sub btnFindItem_Click(sender As Object, e As EventArgs) Handles btnFindItem.Click

        Dim fqn As String = ""
        Dim db As String = txtDb.Text.ToUpper
        Dim i As Integer = db.IndexOf("EMAILATTACHMENT")
        Dim j As Integer = db.IndexOf("DataSource")

        If i >= 0 Then
            fqn = DBArch.getFqnFromGuid(txtSourceGuid.Text, "EmailAttachment")
            SBFqn.Text = fqn
            SB.Text = Path.GetFileName(fqn)
        ElseIf j >= 0 Then
            fqn = DBArch.getFqnFromGuid(txtSourceGuid.Text)
            SBFqn.Text = fqn
            SB.Text = Path.GetFileName(fqn)
        Else
            SB.Text = "NOTICE: Cannot retrieve data from this information."
        End If


    End Sub
End Class