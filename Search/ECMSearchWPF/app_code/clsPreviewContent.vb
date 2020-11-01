
Public Class clsPreviewContent
    Public Sub PreviewDoc()
        'Dim uri As Uri = New Uri("http://www.ecmlibrary/$Preview/LCSE-900010Firmware Support Manual.PDF", UriKind.RelativeOrAbsolute)
        Try
            System.Diagnostics.Process.Start("http://www.ecmlibrary/$Preview/LCSE-900010Firmware Support Manual.PDF")
        Catch
            'Code to handle the error.
        End Try

    End Sub
End Class
