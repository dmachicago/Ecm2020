' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="clsGridMgt.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
''' <summary>
''' Class clsGridMgt.
''' </summary>
Public Class clsGridMgt

    ''' <summary>
    ''' The iso
    ''' </summary>
    Dim ISO As New clsIsolatedStorage

    ''' <summary>
    ''' Saves the state of the grid.
    ''' </summary>
    ''' <param name="Userid">The userid.</param>
    ''' <param name="ScreenName">Name of the screen.</param>
    ''' <param name="DG">The dg.</param>
    ''' <param name="Dict">The dictionary.</param>
    Sub SaveGridState(ByVal Userid As String,
                      ByVal ScreenName As String,
                      ByVal DG As DataGrid,
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

    ''' <summary>
    ''' Saves the grid dictionary.
    ''' </summary>
    ''' <param name="DG">The dg.</param>
    ''' <param name="Dict">The dictionary.</param>
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

    ''' <summary>
    ''' Gets the state of the grid.
    ''' </summary>
    ''' <param name="ScreenName">Name of the screen.</param>
    ''' <param name="GridName">Name of the grid.</param>
    ''' <param name="UID">The uid.</param>
    ''' <param name="Dict">The dictionary.</param>
    Sub getGridState(ByVal ScreenName As String,
                     ByVal GridName As String,
                     ByVal UID As String,
                     ByRef Dict As Dictionary(Of Integer, String))

        ISO.ReadGridColDisplayOrder(ScreenName, GridName, UID, Dict)

    End Sub

End Class
