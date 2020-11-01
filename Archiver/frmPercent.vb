
Public Class frmPercent

    Public fSize As Double = 0

    Sub New()
        ' This call is required by the designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.

        If fSize = 0 Then
            Me.Label1.Visible = False
        Else
            Me.Label1.Text = "Loading File of Size: " & fSize
        End If

    End Sub

End Class
