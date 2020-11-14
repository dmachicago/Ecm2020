Public Class frmLocalParameters

    Sub New()
        ' This call is required by the Windows Form Designer.
        InitializeComponent()

    End Sub

    Sub LoadParms()

    End Sub

    Function UpdateParm() As Boolean
        Dim B As Boolean = True
        Try

        Catch ex As Exception
            B = False
        End Try
        Return B
    End Function

    Function DeleteParm() As Boolean
        Dim B As Boolean = True
        Try

        Catch ex As Exception
            B = False
        End Try
        Return B
    End Function

    Function AddParm() As Boolean
        Dim B As Boolean = True
        Try

        Catch ex As Exception
            B = False
        End Try
        Return B
    End Function

    Private Sub DataGridView1_CellContentClick(sender As Object, e As DataGridViewCellEventArgs) Handles dgParms.CellContentClick

        Try

        Catch ex As Exception
            Console.WriteLine(ex.Message)
        End Try

    End Sub
End Class