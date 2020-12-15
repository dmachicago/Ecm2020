' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="clsPreviewContent.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************

''' <summary>
''' Class clsPreviewContent.
''' </summary>
Public Class clsPreviewContent
    ''' <summary>
    ''' Previews the document.
    ''' </summary>
    Public Sub PreviewDoc()
        'Dim uri As Uri = New Uri("http://www.ecmlibrary/$Preview/LCSE-900010Firmware Support Manual.PDF", UriKind.RelativeOrAbsolute)
        Try
            System.Diagnostics.Process.Start("http://www.ecmlibrary/$Preview/LCSE-900010Firmware Support Manual.PDF")
        Catch
            'Code to handle the error.
        End Try

    End Sub
End Class
