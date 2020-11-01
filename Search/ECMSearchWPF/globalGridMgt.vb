Imports System.Data
Imports System.IO
Imports System.Windows.Controls.Primitives

Module globalGridMgt

    ''' <summary>
    ''' Gets the column value for the passed in column name.
    ''' </summary>
    ''' <param name="DG">The datagrid.</param>
    ''' <param name="ColName">Name of the datagrid column.</param>
    ''' <returns>If column not found returns nothing, otherwise returns the tgt column's value as an object</returns>
    Public Function getColvalue(DG As DataGrid, ColName As String) As Object

        Dim oVal As Object = Nothing
        Dim items = DG.SelectedItems

        If Not items.Count.Equals(1) Then
            Return Nothing
        End If

        For Each item As DataRowView In items
            Try
                oVal = item(ColName)
            Catch ex As Exception

                WriteErrorLog("ERROR 221 globalGridMgt/getColvalue : " + DG.Name + " / " + ColName + Environment.NewLine + ex.Message)
                oVal = Nothing
            End Try

        Next

        Return oVal

    End Function


    ''' <summary>
    ''' Hides the grid column.
    ''' </summary>
    ''' <param name="DG">The dg.</param>
    ''' <param name="ColName">Name of the col.</param>
    Public Sub HideGridColumn(DG As DataGrid, ColName As String)

        Dim idX As Integer = getColIdx(DG, ColName)

        If idX < 0 Then
            Return
        End If

        DG.Columns(idX).Visibility = Visibility.Collapsed
        DG.Items.Refresh()

    End Sub

    ''' <summary>
    ''' Gets the selected row.
    ''' </summary>
    ''' <param name="DG">The dg.</param>
    ''' <returns>DataGridRow</returns>
    Public Function GetSelectedRow(ByVal DG As DataGrid) As DataGridRow
        Return CType(DG.ItemContainerGenerator.ContainerFromItem(DG.SelectedItem), DataGridRow)
    End Function

    ''' <summary>
    ''' Gets the index of the row by.
    ''' </summary>
    ''' <param name="DG">The dg.</param>
    ''' <param name="index">The index.</param>
    ''' <returns>DataGridRow</returns>
    Public Function GetRowByIdx(ByVal DG As DataGrid, ByVal index As Integer) As DataGridRow

        Dim row As DataGridRow = CType(DG.ItemContainerGenerator.ContainerFromIndex(index), DataGridRow)

        If row Is Nothing Then
            DG.UpdateLayout()
            DG.ScrollIntoView(DG.Items(index))
            row = CType(DG.ItemContainerGenerator.ContainerFromIndex(index), DataGridRow)
        End If

        Return row
    End Function

    Public Function GetCell(ByVal DG As DataGrid, ByVal row As DataGridRow, ByVal column As Integer) As DataGridCell
        If row IsNot Nothing Then
            Dim presenter As DataGridCellsPresenter = GetVisualChild(Of DataGridCellsPresenter)(row)

            If presenter Is Nothing Then
                DG.ScrollIntoView(row, DG.Columns(column))
                presenter = GetVisualChild(Of DataGridCellsPresenter)(row)
            End If

            Dim cell As DataGridCell = CType(presenter.ItemContainerGenerator.ContainerFromIndex(column), DataGridCell)
            Return cell
        End If

        Return Nothing
    End Function

    Public Function GetVisualChild(Of T As Visual)(ByVal parent As Visual) As T
        Dim child As T = Nothing
        Dim numVisuals As Integer = VisualTreeHelper.GetChildrenCount(parent)

        For i As Integer = 0 To numVisuals - 1
            Dim v As Visual = CType(VisualTreeHelper.GetChild(parent, i), Visual)
            child = TryCast(v, T)

            If child Is Nothing Then
                child = GetVisualChild(Of T)(v)
            End If

            If child IsNot Nothing Then
                Exit For
            End If
        Next

        Return child
    End Function

    Public Function getColIdx(DG As DataGrid, ColName As String) As Integer

        Dim idx As Integer = -1
        Dim colidx As Integer = -1

        For Each col As DataGridColumn In DG.Columns
            idx += 1
            Dim tgt As String = col.Header.ToString
            If tgt.Trim.ToUpper.Equals(ColName.Trim.ToUpper) Then
                Return idx
            End If
        Next
        idx = -1
        Return idx
    End Function

    Public Function getCellValue(DG As DataGrid, ColName As String) As String

        Dim idx As Integer = getColIdx(DG, ColName)
        Dim SelRow As DataGridRow = GetSelectedRow(DG)
        Dim item As Object = DG.SelectedItem
        Dim val As String = ""
        Dim RowIdx As Integer = SelRow.GetIndex

        idx = -1
        For Each col As DataGridColumn In DG.Columns
            Dim tgt As String = col.Header.ToString
            If tgt.ToUpper.Equals(ColName.ToUpper) Then
                idx = getColIdx(DG, tgt)
                Try
                    'Dim DR As DataGridRow = DG.SelectedItems(RowIdx)
                    'Dim O As Object = DR.Item

                    val = (TryCast(DG.SelectedCells(idx).Column.GetCellContent(item), TextBlock)).Text
                Catch ex As Exception
                    Console.WriteLine(ex.Message)

                    val = ""
                End Try
                Return val
            End If
        Next

        Return val
    End Function
    Public Function getStringCellValue(DG As DataGrid, ColName As String) As String

        Dim idx As Integer = getColIdx(DG, ColName)
        Dim SelRow As DataGridRow = GetSelectedRow(DG)
        Dim item As Object = DG.SelectedItem
        Dim val As String = ""
        Dim RowIdx As Integer = SelRow.GetIndex

        idx = -1
        For Each col As DataGridColumn In DG.Columns
            Dim tgt As String = col.Header.ToString
            If tgt.ToUpper.Equals(ColName.ToUpper) Then
                idx = getColIdx(DG, tgt)
                Try
                    'Dim DR As DataGridRow = DG.SelectedItems(RowIdx)
                    'Dim O As Object = DR.Item

                    val = (TryCast(DG.SelectedCells(idx).Column.GetCellContent(item), TextBlock)).Text
                Catch ex As Exception
                    Console.WriteLine(ex.Message)

                    val = ""
                End Try
                Return val
            End If
        Next

        Return val
    End Function

    ''' <summary>
    ''' Example of how to Loop selected rows.
    ''' </summary>
    ''' <param name="DG">The datagrid to be processed.</param>
    ''' <returns></returns>
    Public Function LoopSelectedRows(ByVal DG As DataGrid) As DataRowView

        Dim items = DG.SelectedItems
        Dim item As DataRowView = Nothing

        For Each item In items
            Dim SourceGuid = item("SourceGuid")
            Dim clSiteRootUrl = item("clSiteRootUrl")
        Next

        Return item

    End Function

    Public Function fetchCell(DG As DataGrid, ColName As String) As String

        Dim items = DG.SelectedItems
        Dim item As DataRowView = Nothing
        Dim val As String = ""

        Try
            For Each item In items
                val = item(ColName)
            Next
        Catch ex As Exception
            Console.WriteLine("ERROR fetchCell: " + ex.Message)
            Return ""
        End Try


        Return val
    End Function

    Public Function fetchCellValue(DG As DataGrid, ColName As String) As String

        Dim q As Integer = getColIdx(DG, ColName)
        Dim item As Object = DG.SelectedItem

        Try
            Dim S As TextBlock = (TryCast(DG.SelectedCells(q).Column.GetCellContent(item), TextBlock))
            Return S.Text
        Catch ex As Exception
            Try
                Dim dtime As Object = DG.SelectedCells(q).Column.GetCellContent(item)
                Console.WriteLine(dtime.value.ToString)
                Dim S As String = CType(dtime, String)
                Return dtime.ToString
            Catch ex1 As Exception
                Try
                    'Dim ival As Int64 = (TryCast(DG.SelectedCells(q).Column.GetCellContent(item), Integer))
                    'Dim dtime As Object = DG.SelectedCells(q).Column.GetCellContent(item)
                    Dim O As Object = DG.SelectedCells(q).Column.GetCellContent(item)
                    Dim S As String = DirectCast(O, String)
                    Return S
                Catch ex3 As Exception
                    Try
                        'Dim bval As Boolean = (TryCast(DG.SelectedCells(q).Column.GetCellContent(item), Boolean))
                        Dim O As Object = DG.SelectedCells(q).Column.GetCellContent(item)
                        Dim S As String = DirectCast(O, String)
                        Return S
                    Catch ex4 As Exception
                        Console.WriteLine("ERROR EX4 fetchCellValue: ColName: " + ColName + "  ....." + ex4.Message)
                    End Try
                    Console.WriteLine("ERROR EX3 fetchCellValue: ColName: " + ColName + "  ....." + ex3.Message)
                End Try
                Console.WriteLine("ERROR EX1 fetchCellValue: ColName: " + ColName + "  ....." + ex1.Message)
            End Try
            Console.WriteLine("ERROR EX fetchCellValue: ColName: " + ColName + "  ....." + ex.Message)
            Return ""
        End Try
    End Function

    Public Function LoadCellValue(DG As DataGrid) As Dictionary(Of String, String)

        Dim DV As Dictionary(Of String, String) = New Dictionary(Of String, String)
        Dim idx As Integer = 0
        'Dim SelRow As DataGridRow = GetSelectedRow(DG)
        Dim item As Object = DG.SelectedItem
        Dim val As String = ""
        Dim RowIdx As Integer = DG.SelectedIndex
        Dim tgt As String = ""

        idx = -1
        For Each col As DataGridColumn In DG.Columns
            idx += 1
            tgt = col.Header.ToString
            idx = getColIdx(DG, tgt)
            Try

                Dim q As Integer = getColIdx(DG, tgt)
                val = fetchCellValue(DG, tgt)
                'Dim x As TextBlock = (TryCast(DG.SelectedCells(idx).Column.GetCellContent(item), TextBlock))
                'val = x.Text
                DV.Add(tgt, val)
            Catch ex As Exception
                Console.WriteLine(ex.Message)
                val = ""
            End Try
        Next

        Return DV
    End Function

    Public Sub WriteErrorLog(ByVal Msg As String)
        Try
            'Dim cPath As String = LOG.getTempEnvironDir()

            If Not Directory.Exists("c:\ECMLogs") Then
                Directory.CreateDirectory("c:\ECMLogs")
            End If
            'Dim TempFolder As String = LOG.getTempEnvironDir()
            Dim TempFolder As String = "c:\ECMLogs\"
            Dim M As String = Now.Month.ToString.Trim
            Dim D As String = Now.Day.ToString.Trim
            Dim Y As String = Now.Year.ToString.Trim

            Dim SerialNo$ = M + "." + D + "." + Y + "."

            Dim tFQN As String = TempFolder + "ECMLibrary.GridError.Log." + SerialNo$ + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.
                sw.WriteLine(Now.ToString + ": " + Msg)
                sw.Close()
            End Using
        Catch ex As Exception
            MsgBox("clsLogging : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub

End Module
