Public Class clsGridMgt

    Dim ISO As New clsIsolatedStorage

    Sub SaveGridState(ByVal Userid As String, _
                      ByVal ScreenName As String, _
                      ByVal DG As DataGrid, _
                      ByRef Dict As Dictionary(Of Integer, String))

        Dim ColDisplayOrder As String = DG.Name + " Column Display Order: " + vbCrLf
        Dict.Clear()
        For I As Integer = 0 To DG.Columns.Count - 1
            Dim sCol As String = DG.Columns(I).Header
            ColDisplayOrder += sCol + vbCrLf
            If Dict.ContainsKey(I) Then
                Dict.Item(I) = sCol
            Else
                Dict.Add(I, sCol)
            End If
        Next

        'MessageBox.Show(ColDisplayOrder)

        ISO.SaveGridColDisplayOrder(ScreenName, DG.Name, Userid, Dict)

    End Sub

    Sub SaveGridDictionary(ByVal DG As DataGrid, ByRef Dict As Dictionary(Of Integer, String))

        For I As Integer = 0 To DG.Columns.Count - 1
            Dim ColName As String = DG.Columns(I).Header
            If Dict.ContainsKey(I) Then
                Dict.Item(I) = ColName
            Else
                Dict.Add(I, ColName)
            End If
        Next

    End Sub

    Sub getGridState(ByVal ScreenName As String, _
                     ByVal GridName As String, _
                     ByVal UID As String, _
                     ByRef Dict As Dictionary(Of Integer, String))

        ISO.ReadGridColDisplayOrder(ScreenName, GridName, UID, Dict)

    End Sub

End Class
