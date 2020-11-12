Public Class frmSqlHelp
    Private Sub RichTextBox1_TextChanged(sender As Object, e As EventArgs) Handles rtbFile.TextChanged

    End Sub

    Private Sub cbDirectory_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cbDirectory.SelectedIndexChanged
        Dim DIR As String = ""
        Dim FN As String = ""
        Try
            Dim idx As Integer = cbDirectory.SelectedIndex
            If cbDirectory.Items(idx).ToString.Equals("Fulltext Index Routines") Then
                DIR = My.Application.Info.DirectoryPath + "\_FTI"
                Dim files() As String = IO.Directory.GetFiles(DIR)
                lbFiles.Items.Clear()

                For Each file As String In files
                    FN = IO.Path.GetFileName(file)
                    lbFiles.Items.Add(FN)
                    'Dim text As String = IO.File.ReadAllText(file)
                Next
            ElseIf cbDirectory.Items(idx).ToString.Equals("SQL Routines") Then
                DIR = My.Application.Info.DirectoryPath + "\_SQL_Query"
                Dim files() As String = IO.Directory.GetFiles(DIR)
                lbFiles.Items.Clear()

                For Each file As String In files
                    FN = IO.Path.GetFileName(file)
                    lbFiles.Items.Add(FN)
                    'Dim text As String = IO.File.ReadAllText(file)
                Next
            End If
        Catch ex As Exception
            MessageBox.Show("Oh No! Something went wrong..." + Environment.NewLine + ex.Message)
        End Try

    End Sub

    Private Sub btnOpenFile_Click(sender As Object, e As EventArgs) Handles btnOpenFile.Click
        Try
            Dim DIR As String = ""
            Dim FileName As String = ""
            Dim FQN As String = ""
            Dim idx As Integer = cbDirectory.SelectedIndex
            If cbDirectory.Items(idx).ToString.Equals("Fulltext Index Routines") Then
                DIR = My.Application.Info.DirectoryPath + "\_FTI"
                FileName = lbFiles.SelectedItems(0)
                FQN = DIR + "\" + FileName
            ElseIf cbDirectory.Items(idx).ToString.Equals("SQL Routines") Then
                DIR = My.Application.Info.DirectoryPath + "\_SQL_Query"
                FileName = lbFiles.SelectedItems(0)
                FQN = DIR + "\" + FileName
            End If
            rtbFile.Text = FileIO.FileSystem.ReadAllText(FQN)
        Catch ex As Exception
            MessageBox.Show("Oh No! Something went wrong..." + Environment.NewLine + ex.Message)
        End Try

    End Sub

    Private Sub btnCopy_Click(sender As Object, e As EventArgs) Handles btnCopy.Click
        Try
            Dim txt As String = ""
            txt = rtbFile.Text
            Clipboard.Clear()
            Clipboard.SetText(txt)
            MessageBox.Show("File text is in the Clipboard...")
        Catch ex As Exception
            MessageBox.Show("Oh No! Something went wrong..." + Environment.NewLine + ex.Message)
        End Try

    End Sub

    Private Sub btnAddFile_Click(sender As Object, e As EventArgs) Handles btnAddFile.Click

        Try
            Dim DIR As String = ""
            Dim FQN As String = ""
            Dim Idx As Integer = cbDirectory.SelectedIndex
            If cbDirectory.Items(Idx).ToString.Equals("Fulltext Index Routines") Then
                DIR = My.Application.Info.DirectoryPath + "\_FTI"
            ElseIf cbDirectory.Items(Idx).ToString.Equals("SQL Routines") Then
                DIR = My.Application.Info.DirectoryPath + "\_SQL_Query"
            End If

            Dim NewFile As String = ""
            Dim FileName As String = ""
            Dim result As DialogResult = OpenFileDialog1.ShowDialog()
            If result = Windows.Forms.DialogResult.OK Then
                NewFile = OpenFileDialog1.FileName
                FileName = IO.Path.GetFileName(NewFile)
                FQN = DIR + "\" + FileName
                My.Computer.FileSystem.CopyFile(NewFile, FQN, overwrite:=False)
                MessageBox.Show("File copied...")
                cbDirectory_SelectedIndexChanged(Nothing, Nothing)
            End If
        Catch ex As Exception
            MessageBox.Show("Oh No! Something went wrong..." + Environment.NewLine + ex.Message)
        End Try


    End Sub
End Class