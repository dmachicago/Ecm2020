Public Class popSqlStmt

    Dim SqlText As String = ""
    Dim COMMON As New clsCommonFunctions
    Dim Userid As String

    Public Sub New(ByVal rtbSqlText As String)
        InitializeComponent()

        Userid = _UserID
        COMMON.SaveClick(6930, Userid)

        SqlText = rtbSqlText
        rtbSql.Text = SqlText

    End Sub

    Private Sub CancelButton_Click(ByVal sender As Object, ByVal e As RoutedEventArgs) Handles CancelButton.Click
        'Me.Visibility = Windows.Visibility.Collapsed
        Me.Close()
    End Sub

    Private Sub hlCopy_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlCopy.Click
        Try
            Clipboard.SetText(rtbSql.Text)
            MessageBox.Show("Qry in clipboard")
        Catch ex As Exception
            MessageBox.Show("Could not place Qry in clipboard, copy and paste from the window please.")
        End Try

    End Sub

End Class
