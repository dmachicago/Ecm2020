Imports System.IO

Public Class frmLoadTest
    Private Sub lbFiles_SelectedIndexChanged(sender As Object, e As EventArgs) Handles lbFiles.SelectedIndexChanged

    End Sub

    Private Sub frmLoadTest_Load(sender As Object, e As EventArgs) Handles MyBase.Load

    End Sub

    Private Sub btnDir_Click(sender As Object, e As EventArgs) Handles btnDir.Click

        Dim result As DialogResult = FolderBrowserDialog1.ShowDialog()

        ' Test result.
        If result = Windows.Forms.DialogResult.OK Then
            txtDir.Text = FolderBrowserDialog1.SelectedPath
        End If

    End Sub

    Private Sub btnRun_Click(sender As Object, e As EventArgs) Handles btnRun.Click
        Dim dir As New DirectoryInfo(txtDir.Text)

        lbDirs.Items.Clear()
        lbDirs.Items.Add(dir)
        lbDirs.Sorted = True

        For Each dirItem As DirectoryInfo In dir.GetDirectories
            lbDirs.Items.Add(dirItem.FullName)
        Next

    End Sub

    Private Sub lbDirs_SelectedIndexChanged(sender As Object, e As EventArgs) Handles lbDirs.SelectedIndexChanged
        Dim targetDirectory As String = ""
        targetDirectory = lbDirs.SelectedItems(0).ToString
        Dim txtFilesArray As String() = Nothing
        If ckSubdir.Checked Then
            txtFilesArray = Directory.GetFiles(targetDirectory, "*.*", SearchOption.AllDirectories)
        Else
            txtFilesArray = Directory.GetFiles(targetDirectory, "*.*", SearchOption.TopDirectoryOnly)
        End If

        lbFiles.Items.Clear()
        lbFiles.Sorted = True

        For Each fname As String In txtFilesArray
            lbFiles.Items.Add(fname)
        Next
    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim SearchTgt As String = txtSearch.Text.ToLower
        Dim S As String = ""
        Dim J As Integer = 0
        Dim iCnt As Integer = 0
        lbFiles.SelectedItems.Clear()
        For I As Integer = 0 To lbFiles.Items.Count - 1
            S = lbFiles.Items(I).ToString.ToLower
            J = S.IndexOf(SearchTgt)
            If J >= 0 Then
                lbFiles.SetSelected(I, True)
                iCnt += 1
            End If
        Next
        MessageBox.Show("Items Found: " + iCnt.ToString)
    End Sub

End Class
