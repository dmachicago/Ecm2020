Imports System.IO.IsolatedStorage
Imports System.Threading
Imports System.Windows.Media
Imports System.Windows.Media.Imaging
Imports System.Data
Imports System.Windows.Controls
Imports System.Windows.Controls.Primitives
Imports System.IO

Public NotInheritable Class grid

    Private Sub New()
    End Sub


    Public Shared Sub SelectRowByIndex(dataGrid As DataGrid, rowIndex As Integer)
        If Not dataGrid.SelectionUnit.Equals(DataGridSelectionUnit.FullRow) Then
            Throw New ArgumentException("The SelectionUnit of the DataGrid must be set to FullRow.")
        End If

        If rowIndex < 0 OrElse rowIndex > (dataGrid.Items.Count - 1) Then
            Throw New ArgumentException(String.Format("{0} is an invalid row index.", rowIndex))
        End If

        dataGrid.SelectedItems.Clear()
        ' set the SelectedItem property 

        Dim item As Object = dataGrid.Items(rowIndex)
        ' = Product X
        dataGrid.SelectedItem = item

        Dim row As DataGridRow = TryCast(dataGrid.ItemContainerGenerator.ContainerFromIndex(rowIndex), DataGridRow)
        If row Is Nothing Then
            ' bring the data item (Product object) into view
            '             * in case it has been virtualized away 

            dataGrid.ScrollIntoView(item)
            row = TryCast(dataGrid.ItemContainerGenerator.ContainerFromIndex(rowIndex), DataGridRow)
        End If
    End Sub

    Public Shared Function DictionaryFromType(atype As Object) As Dictionary(Of String, Object)
        If atype Is Nothing Then
            Return New Dictionary(Of String, Object)()
        End If
        Dim t As Type = atype.[GetType]()
        Dim props As System.Reflection.PropertyInfo() = t.GetProperties()
        Dim dict As New Dictionary(Of String, Object)()
        For Each prp As System.Reflection.PropertyInfo In props
            Dim value As Object = prp.GetValue(atype, New Object() {})
            Dim VType As VariantType = VarType(value)
            Dim VStr As String = VType.ToString
            Dim val As String = VType.GetType().ToString
            dict.Add(prp.Name, VStr)
        Next
        Return dict
    End Function

    Public Shared Function PropertiesFromType(atype As Object) As String()
        If atype Is Nothing Then
            Return New String() {}
        End If

        Dim t As Type = atype.[GetType]()
        Dim props As System.Reflection.PropertyInfo() = t.GetProperties()
        Dim propNames As New List(Of String)()

        For Each prp As System.Reflection.PropertyInfo In props
            Dim oRType As Object = prp.ReflectedType
            Dim oType As Object = prp.GetType()
            Dim oProp As Object = prp.PropertyType
            propNames.Add(prp.Name)
        Next

        Return propNames.ToArray()
    End Function

    Public Shared Function enumClass() As Dictionary(Of Object, Object)

        Dim D As Dictionary(Of Object, Object) = New Dictionary(Of Object, Object)()
        Dim T As New tempdata()
        Dim typ As Type = T.GetType
        Dim props As System.Reflection.PropertyInfo() = typ.GetProperties()

        For Each prp As System.Reflection.PropertyInfo In props
            'Dim val As Object = prp.GetValue(typ)
            Dim Obj1 As String = prp.Name
            Dim Obj2 As Object = prp.GetType
            D.Add(prp.Name, prp.GetType)
            Console.Write("{0} , {1}", prp.Name, prp.GetType)
        Next

        'For Each prop As Object In T.GetType().GetProperties()
        '    Dim O1 As Object = prop.GetType
        '    Dim O2 As Object = prop.ToString
        '    Console.Write("{0} , {1}", O1, O2)
        '    D.Add(O2, O1)
        'Next
        Return D
    End Function

    Public Shared Function GetCelValue(dgrid As DataGrid) As String
        Dim DR As Object = dgrid.SelectedItems(0)
        Dim str As String = ""

        Dim i As Int32 = DR.age
        str = DR.email

        Return str
    End Function

    Public Shared Function GetCelValue(dgrid As DataGrid, ColName As String) As String
        Dim DR As Object = dgrid.SelectedItems(0)
        Dim str As String = ""
        Dim RowIdx As Integer = dgrid.SelectedIndex
        'Dim i As Int32 = DR.age
        'str = DR.email

        str = grid.GetCellValueAsString(dgrid, RowIdx, ColName)

        Return str
    End Function

    Public Shared Function GetCelValue(dgrid As DataGrid, RowIdx As Integer, ColName As String) As String
        Dim DR As Object = dgrid.Items(RowIdx)
        Dim str As String = ""

        'Dim i As Int32 = DR.age
        'str = DR.email

        str = grid.GetCellValueAsString(dgrid, RowIdx, ColName)

        Return str
    End Function

    Public Shared Function GetSelectedCell(dataGrid As DataGrid, rowContainer As DataGridRow, column As Integer) As DataGridCell
        If rowContainer IsNot Nothing Then
            Dim presenter As DataGridCellsPresenter = FindVisualChild(Of DataGridCellsPresenter)(rowContainer)
            If presenter Is Nothing Then
                ' if the row has been virtualized away, call its ApplyTemplate() method
                '             * to build its visual tree in order for the DataGridCellsPresenter
                '             * and the DataGridCells to be created

                rowContainer.ApplyTemplate()
                presenter = FindVisualChild(Of DataGridCellsPresenter)(rowContainer)
            End If
            If presenter IsNot Nothing Then
                Dim cell As DataGridCell = TryCast(presenter.ItemContainerGenerator.ContainerFromIndex(column), DataGridCell)
                If cell Is Nothing Then
                    ' bring the column into view
                    '                 * in case it has been virtualized away

                    dataGrid.ScrollIntoView(rowContainer, dataGrid.Columns(column))
                    cell = TryCast(presenter.ItemContainerGenerator.ContainerFromIndex(column), DataGridCell)
                End If
                Return cell
            End If
        End If
        Return Nothing
    End Function

    Public Shared Sub SelectCellByIndex(dataGrid As DataGrid, rowIndex As Integer, columnIndex As Integer)
        If Not dataGrid.SelectionUnit.Equals(DataGridSelectionUnit.Cell) Then
            Throw New ArgumentException("The SelectionUnit of the DataGrid must be set to Cell.")
        End If

        If rowIndex < 0 OrElse rowIndex > (dataGrid.Items.Count - 1) Then
            Throw New ArgumentException(String.Format("{0} is an invalid row index.", rowIndex))
        End If

        If columnIndex < 0 OrElse columnIndex > (dataGrid.Columns.Count - 1) Then
            Throw New ArgumentException(String.Format("{0} is an invalid column index.", columnIndex))
        End If

        dataGrid.SelectedCells.Clear()

        Dim item As Object = dataGrid.Items(rowIndex)
        '=Product X
        Dim row As DataGridRow = TryCast(dataGrid.ItemContainerGenerator.ContainerFromIndex(rowIndex), DataGridRow)
        If row Is Nothing Then
            dataGrid.ScrollIntoView(item)
            row = TryCast(dataGrid.ItemContainerGenerator.ContainerFromIndex(rowIndex), DataGridRow)
        End If
        If row IsNot Nothing Then
            Dim cell As DataGridCell = GetCell(dataGrid, row, columnIndex)
            If cell IsNot Nothing Then
                Dim dataGridCellInfo As New DataGridCellInfo(cell)
                dataGrid.SelectedCells.Add(dataGridCellInfo)
                cell.Focus()
            End If
        End If
    End Sub

    Public Shared Function FindVisualChild(Of T As DependencyObject)(obj As DependencyObject) As T
        For i As Integer = 0 To VisualTreeHelper.GetChildrenCount(obj) - 1
            Dim child As DependencyObject = VisualTreeHelper.GetChild(obj, i)
            If child IsNot Nothing AndAlso TypeOf child Is T Then
                Return DirectCast(child, T)
            Else
                Dim childOfChild As T = FindVisualChild(Of T)(child)
                If childOfChild IsNot Nothing Then
                    Return childOfChild
                End If
            End If
        Next
        Return Nothing
    End Function

    Public Shared Function MakeNewWeakReference(Of T As Class)(Obj As T) As WeakReference
        Return New WeakReference(Obj)
    End Function

    Public Shared Function updateCellThruDataStructure(dgrid As DataGrid, RowIdx As Integer, ColIndex As Integer, newValue As Object) As Boolean
        Dim bResetToRowMode As Boolean = False
        Dim O As DataGridSelectionUnit = dgrid.SelectionUnit

        If O.Equals(DataGridSelectionUnit.FullRow) Then
            dgrid.SelectionUnit = DataGridSelectionUnit.Cell
            bResetToRowMode = True
        End If

        Dim B As Boolean = True
        Dim I As Integer = 0
        Dim TRow As New tempdata()

        Try
            For Each TRow In dgrid.ItemsSource
                Dim s As String = TRow.ToString
                If I = RowIdx Then
                    TRow.dg_age = newValue
                End If
                I = I + 1
            Next
            dgrid.Items.Refresh()
            If bResetToRowMode.Equals(True) Then
                dgrid.SelectionUnit = DataGridSelectionUnit.FullRow
            End If
        Catch ex As Exception
            B = False
        End Try

        Return B
    End Function

    Public Shared Function updateCellThruDataStructure(dgrid As DataGrid, RowIdx As Integer, ColName As String, newValue As Object) As Boolean
        Dim bResetToRowMode As Boolean = False
        Dim O As DataGridSelectionUnit = dgrid.SelectionUnit

        If O.Equals(DataGridSelectionUnit.FullRow) Then
            dgrid.SelectionUnit = DataGridSelectionUnit.Cell
            bResetToRowMode = True
        End If

        Dim B As Boolean = True
        Dim I As Integer = 0
        Dim TRow As New tempdata()

        Try
            For Each TRow In dgrid.ItemsSource
                If I = RowIdx Then
                    TRow.dg_age = newValue
                End If
                I = I + 1
            Next
            dgrid.Items.Refresh()
            If bResetToRowMode.Equals(True) Then
                dgrid.SelectionUnit = DataGridSelectionUnit.FullRow
            End If
        Catch ex As Exception
            B = False
        End Try

        Return B
    End Function

    Public Shared Function updateCell(dgrid As DataGrid, RowIdx As Integer, ColName As String, newValue As Object) As Boolean
        Dim B As Boolean = True
        Try
            Dim iCol As Integer = getColumnIndexByName(dgrid, ColName)
            SelectCellByIndex(dgrid, RowIdx, iCol)

            Dim R As DataGridRow = Nothing
            R = GetRow(dgrid, RowIdx)

            Dim DC As DataGridCell = Nothing
            DC = GetCell(dgrid, R, iCol)
            DC.Content = newValue
            dgrid.Items.Refresh()
            Return True
        Catch ex As Exception
            B = False
        End Try

        Return B
    End Function

    ''' <summary>
    ''' Enums the grid cols and returns a list of names in display order
    ''' </summary>
    ''' <param name="dgrid">The dgrid.</param>
    ''' <returns>returns a list of names in display order</returns>
    Public Shared Function EnumGridCols(dgrid As DataGrid) As Dictionary(Of Integer, String)
        Dim LCols As Dictionary(Of Integer, String) = New Dictionary(Of Integer, String)
        'Dim iTot As Integer = dgrid.Columns.Count - 1
        'Dim iCol As Integer = 0
        'For i As Integer = 0 To iTot
        '    Dim tCol As DataGridColumn = dgrid.Columns(i)
        '    Dim name As String = tCol.Header
        '    Dim ii As Integer = tCol.DisplayIndex
        '    Console.WriteLine(name, ii)
        'Next
        For Each C As DataGridColumn In dgrid.Columns
            Dim name As String = C.Header
            Dim ii As Integer = C.DisplayIndex
            LCols.Add(ii, name)
        Next

        Return LCols

    End Function

    ''' <summary>
    ''' Enums objects within the grid tree.
    ''' </summary>
    ''' <param name="DGRID">The dgrid.</param>
    Public Shared Sub EnumGridTree(DGRID As DependencyObject, ByRef ObjectList As Dictionary(Of String, String))

        For i As Integer = 0 To VisualTreeHelper.GetChildrenCount(DGRID) - 1
            Dim child = VisualTreeHelper.GetChild(DGRID, i)
            Dim sType As String = child.GetType.ToString

            Dim OName As Object = child.GetType.Name
            Dim OType As Object = child.GetType.FullName
            If Not ObjectList.ContainsKey(OName) Then
                ObjectList.Add(OName, OType)
            End If
            EnumGridTree(child, ObjectList)

            'If child IsNot Nothing AndAlso TypeOf child Is ScrollViewer Then
            '    Dim scrollbarname As String = DirectCast(child, ScrollViewer).Name
            '    Console.WriteLine(scrollbarname)
            '    ObjectList.Add(scrollbarname)
            'ElseIf child IsNot Nothing AndAlso TypeOf child Is ScrollBar Then
            '    Dim scrollbarname As String = DirectCast(child, ScrollBar).Name
            '    Console.WriteLine(scrollbarname)
            '    ObjectList.Add(scrollbarname)
            'Else
            '    EnumGridTree(child, ObjectList)
            '    If [ObjectList] IsNot Nothing Then
            '        Return
            '    Else
            '        For Each s As String In ObjectList
            '            ObjectList.Add(s)
            '        Next
            '    End If
            'End If
        Next
        Return
    End Sub

    Public Shared Function GetScrollbar(DGRID As DependencyObject, name As String) As ScrollBar
        For i As Integer = 0 To VisualTreeHelper.GetChildrenCount(DGRID) - 1
            Dim child = VisualTreeHelper.GetChild(DGRID, i)
            If child IsNot Nothing AndAlso TypeOf child Is ScrollBar Then
                Dim scrollbarname As String = DirectCast(child, ScrollBar).Name
                Console.WriteLine(scrollbarname)
                Return TryCast(child, ScrollBar)
            Else
                Dim [SBAR] As ScrollBar = GetScrollbar(child, name)
                If [SBAR] IsNot Nothing Then
                    Return [SBAR]
                End If
            End If
        Next
        Return Nothing
    End Function

    '<System.Runtime.CompilerServices.Extension> _
    Public Shared Function GetDGScrollbar(DGRID As DependencyObject, name As String) As ScrollBar
        For i As Integer = 0 To VisualTreeHelper.GetChildrenCount(DGRID) - 1
            Dim child = VisualTreeHelper.GetChild(DGRID, i)
            If child IsNot Nothing AndAlso TypeOf child Is ScrollBar AndAlso DirectCast(child, ScrollBar).Name = name Then
                Return TryCast(child, ScrollBar)
            Else
                Dim [SBAR] As ScrollBar = GetScrollbar(child, name)
                If [SBAR] IsNot Nothing Then
                    Return [SBAR]
                End If
            End If
        Next
        Return Nothing
    End Function

    Public Shared Function getScrollBarCurrentPct(dg As DataGrid, sbarname As String) As Double
        Try
            Dim sbar As ScrollBar = GetScrollbar(dg, sbarname)
            Dim currpos As Double = sbar.Value
            Dim currmax As Double = sbar.Maximum
            Dim pct As Double = currpos / currmax * 100
            Return pct
        Catch ex As Exception
            Return 0
        End Try

    End Function

    ' Get the current position of the scrollbar.
    Public Shared Function getScrollBarCurrentPosition(dg As DataGrid, sbarname As String) As Double
        Dim sbar As ScrollBar = GetScrollbar(dg, sbarname)
        Return sbar.Value
    End Function

    ''' Gets the scroll bar maximum position.
    Public Shared Function getScrollBarMaxPosition(dg As DataGrid, sbarname As String) As Double
        Dim sbar As ScrollBar = GetScrollbar(dg, sbarname)
        Return sbar.Maximum
    End Function

    Public Shared Function GetSelectedRow(dgrid As DataGrid) As DataGridRow
        Return DirectCast(dgrid.ItemContainerGenerator.ContainerFromItem(dgrid.SelectedItem), DataGridRow)
    End Function

    Public Shared Function getColumnIndexByName(dgrid As DataGrid, ColName As String) As Integer
        Dim cname As String = ""
        Dim i As Integer = -1
        Dim C As DataGridColumn
        Dim f As Boolean = False
        For Each C In dgrid.Columns
            i = i + 1
            cname = C.Header
            If cname.ToUpper.Equals(ColName.ToUpper) Then
                f = True
                Return i
            End If
        Next
        If f = False Then
            i = -1
        End If
        Return i
    End Function

    Public Shared Function getColumnNameByIndex(dgrid As DataGrid, ColIdx As Integer) As String
        Dim cname As String = ""
        Dim i As Integer = -1
        Dim C As DataGridColumn
        For Each C In dgrid.Columns
            i = i + 1
            cname = C.Header
            If i.Equals(ColIdx) Then
                Return cname
            End If
        Next
        Return cname
    End Function

    Public Shared Function GetRow(dgrid As DataGrid, index As Integer) As DataGridRow
        If index < 0 Then
            Return Nothing
        End If
        Dim row As DataGridRow = DirectCast(dgrid.ItemContainerGenerator.ContainerFromIndex(index), DataGridRow)
        If row Is Nothing Then
            ' May be virtualized, bring into view and try again.
            dgrid.UpdateLayout()
            dgrid.ScrollIntoView(dgrid.Items(index))
            row = DirectCast(dgrid.ItemContainerGenerator.ContainerFromIndex(index), DataGridRow)
        End If
        Return row
    End Function

    ''' <summary>
    ''' Gets the cell and returns it as a datagrid cell usign the column name.
    ''' Verified 10/13/2015 by WDM
    ''' </summary>
    ''' <param name="dgrid">The data grid.</param>
    ''' <param name="row">The row.</param>
    ''' <param name="columnName">Name of the column.</param>
    ''' <returns></returns>
    Public Shared Function GetCell(dgrid As DataGrid, row As DataGridRow, columnName As String) As DataGridCell
        Dim column As Integer = -1
        column = getColumnIndexByName(dgrid, columnName)
        If column < 0 Then
            Return Nothing
        End If
        Return GetCell(dgrid, row, column)
    End Function

    Public Shared Function GetCellValueAsString(dgrid As DataGrid, RowIdx As Integer, ColName As String) As String
        Dim ColIDX As Integer = getColumnIndexByName(dgrid, ColName)
        If ColIDX < 0 Then
            Return ""
        End If
        Dim RowNbr As Integer = RowIdx
        Dim str As String = GetCellValueAsString(dgrid, RowIdx, ColIDX)
        Return str
    End Function
    Public Shared Function GetCellValueAsString(dgrid As DataGrid, RowIdx As Integer, ColIDX As Integer) As String
        Dim RowNbr As Integer = RowIdx
        If RowNbr < 0 Then
            Return ""
        End If
        Dim DR As DataGridRow = GetRow(dgrid, RowNbr)
        If DR IsNot Nothing Then

            Dim presenter As DataGridCellsPresenter = GetVisualChild(Of DataGridCellsPresenter)(DR)

            If presenter Is Nothing Then
                dgrid.ScrollIntoView(DR, dgrid.Columns(ColIDX))
                presenter = GetVisualChild(Of DataGridCellsPresenter)(DR)
            End If

            Dim cell As DataGridCell = DirectCast(presenter.ItemContainerGenerator.ContainerFromIndex(ColIDX), DataGridCell)
            Dim stype As System.Type = cell.GetType
            'Dim str As String = TryCast(dgrid.SelectedCells(0).Column.GetCellContent(DR), TextBlock).Text

            Dim str As String = ""
            Try
                str = TryCast(dgrid.SelectedCells(ColIDX).Column.GetCellContent(DR), TextBlock).Text
            Catch ex As Exception
                str = ""
            End Try
            Return str
        End If
        Return Nothing

    End Function

    ''' <summary>
    ''' Gets the cell value as string using the Column Index.
    ''' Verified 10/13/2015 by WDM
    ''' </summary>
    ''' <param name="dgrid">The dgrid.</param>
    ''' <param name="ColIDX">Index of the col.</param>
    ''' <returns></returns>
    Public Shared Function GetCellValueAsString(dgrid As DataGrid, ColIDX As Integer) As String
        Dim RowNbr As Integer = dgrid.SelectedIndex
        If RowNbr < 0 Then
            Return ""
        End If
        Dim DR As DataGridRow = GetRow(dgrid, RowNbr)
        If DR IsNot Nothing Then

            Dim presenter As DataGridCellsPresenter = GetVisualChild(Of DataGridCellsPresenter)(DR)

            If presenter Is Nothing Then
                dgrid.ScrollIntoView(DR, dgrid.Columns(ColIDX))
                presenter = GetVisualChild(Of DataGridCellsPresenter)(DR)
            End If

            Dim cell As DataGridCell = DirectCast(presenter.ItemContainerGenerator.ContainerFromIndex(ColIDX), DataGridCell)
            Dim stype As System.Type = cell.GetType
            Dim str As String = TryCast(dgrid.SelectedCells(0).Column.GetCellContent(DR), TextBlock).Text
            Return str
        End If
        Return Nothing

    End Function

    ''' <summary>
    ''' Gets the cell value as string using the Column name.
    ''' Verified 10/13/2015 by WDM
    ''' </summary>
    ''' <param name="dgrid">The dgrid.</param>
    ''' <param name="ColName">Name of the col.</param>
    ''' <returns></returns>
    Public Shared Function GetCellValueAsString(dgrid As DataGrid, ColName As String) As String

        Dim RowNbr As Integer = dgrid.SelectedIndex
        If RowNbr < 0 Then
            Return ""
        End If
        Dim DR As DataGridRow = GetRow(dgrid, RowNbr)

        If DR IsNot Nothing Then
            Dim ColIDX As Integer = getColumnIndexByName(dgrid, ColName)
            If ColIDX < 0 Then
                Return ""
            End If
            Dim presenter As DataGridCellsPresenter = GetVisualChild(Of DataGridCellsPresenter)(DR)

            If presenter Is Nothing Then
                dgrid.ScrollIntoView(DR, dgrid.Columns(ColIDX))
                presenter = GetVisualChild(Of DataGridCellsPresenter)(DR)
            End If

            Dim cell As DataGridCell = DirectCast(presenter.ItemContainerGenerator.ContainerFromIndex(ColIDX), DataGridCell)
            Dim stype As System.Type = cell.GetType
            Dim str As String = TryCast(dgrid.SelectedCells(ColIDX).Column.GetCellContent(DR), TextBlock).Text
            Return str
        End If
        Return Nothing

    End Function
    Public Shared Function GetVisualChild(Of T As Visual)(parent As Visual) As T
        Dim child As T = Nothing
        Dim numVisuals As Integer = VisualTreeHelper.GetChildrenCount(parent)
        For i As Integer = 0 To numVisuals - 1
            Dim v As Visual = DirectCast(VisualTreeHelper.GetChild(parent, i), Visual)
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

    Public Shared Function GetCellAsCell(grid As DataGrid, row As Integer, column As Integer) As DataGridCell
        Dim rowContainer As DataGridRow = GetRow(grid, row)
        Return GetCell(grid, rowContainer, column)
    End Function
    Public Shared Function GetCellAsString(grid As DataGrid, row As Integer, column As Integer) As DataGridCell
        Dim rowContainer As DataGridRow = GetRow(grid, row)
        Return GetCell(grid, rowContainer, column)
    End Function

    ''' <summary>
    ''' Selects a single row from a datagrid.
    ''' </summary>
    ''' <param name="dataGrid">The data grid.</param>
    ''' <param name="rowIndex">Index of the row.</param>
    ''' <exception cref="ArgumentException">
    ''' The SelectionUnit of the DataGrid must be set to FullRow.
    ''' or
    ''' </exception>
    Public Shared Sub SelectSingleRow(ByRef dataGrid As DataGrid, rowIndex As Integer)
        If Not dataGrid.SelectionUnit.Equals(DataGridSelectionUnit.FullRow) Then
            Throw New ArgumentException("The SelectionUnit of the DataGrid must be set to FullRow.")
        End If

        If rowIndex < 0 OrElse rowIndex > (dataGrid.Items.Count - 1) Then
            Throw New ArgumentException(String.Format("{0} is an invalid row index.", rowIndex))
        End If

        dataGrid.SelectedItems.Clear()
        ' set the SelectedItem property

        Dim item As Object = dataGrid.Items(rowIndex)
        ' = Product X
        dataGrid.SelectedItem = item

        Dim row As DataGridRow = TryCast(dataGrid.ItemContainerGenerator.ContainerFromIndex(rowIndex), DataGridRow)
        If row Is Nothing Then
            ' bring the data item (Product object) into view
            '             * in case it has been virtualized away

            dataGrid.ScrollIntoView(item)
            row = TryCast(dataGrid.ItemContainerGenerator.ContainerFromIndex(rowIndex), DataGridRow)
        End If
        'TODO: Retrieve and focus a DataGridCell object
    End Sub

    ''' <summary>
    ''' Converts the data grid to data table.
    ''' </summary>
    ''' <param name="dg">The datagrid.</param>
    ''' <returns></returns>
    Public Shared Function ConvertDataGridToDataTable(dg As DataGrid) As DataTable
        'Dim o As Object = dataTable.Rows.Item(0).Item("ColumnNameOrIndex")
        dg.SelectAllCells()
        dg.ClipboardCopyMode = DataGridClipboardCopyMode.IncludeHeader
        ApplicationCommands.Copy.Execute(Nothing, dg)
        dg.UnselectAllCells()
        Dim result As [String] = DirectCast(Clipboard.GetData(DataFormats.CommaSeparatedValue), String)
        Dim Lines As String() = result.Split(New String() {vbCr & vbLf, vbLf}, StringSplitOptions.None)
        Dim Fields As String()
        Fields = Lines(0).Split(New Char() {","c})
        Dim Cols As Integer = Fields.GetLength(0)

        Dim dt As New DataTable()
        For i As Integer = 0 To Cols - 1
            dt.Columns.Add(Fields(i).ToUpper(), GetType(String))
        Next
        Dim Row As DataRow
        For i As Integer = 1 To Lines.GetLength(0) - 2
            Fields = Lines(i).Split(New Char() {","c})
            Row = dt.NewRow()
            For f As Integer = 0 To Cols - 1
                Row(f) = Fields(f)
            Next
            dt.Rows.Add(Row)
        Next
        Return dt

    End Function

    Public Shared Function getSelectedCellValue(DG As DataGrid, ColName As String) As String
        Dim item As Object = DG.SelectedItem
        Dim iCol As Integer = getColumnIndexByName(DG, ColName)
        Dim strItem As String = DG.SelectedCells(iCol).Column.GetCellContent(item).ToString
        Return strItem
    End Function

    Private Function FindRowIndex(row As DataGridRow) As Integer
        Dim dataGrid As DataGrid = TryCast(ItemsControl.ItemsControlFromItemContainer(row), DataGrid)

        Dim index As Integer = dataGrid.ItemContainerGenerator.IndexFromContainer(row)

        Return index
    End Function

    ''' <summary>
    ''' Gets the selected cell value for a single selected cell and returns that value as a string.
    ''' </summary>
    ''' <param name="DG">The datagrid.</param>
    ''' <returns></returns>
    Public Shared Function getSelectedCellValue(DG As DataGrid) As String
        Dim cellInfo = DG.SelectedCells(0)
        Dim content = TryCast(cellInfo.Column.GetCellContent(cellInfo.Item), TextBlock).Text
        Return content
    End Function

    Public Shared Function ExportGridToTEXT(DG As DataGrid, UserID As String) As String

        DG.ClipboardCopyMode = DataGridClipboardCopyMode.IncludeHeader
        Dim result As String = Clipboard.GetData(DataFormats.Text).ToString

        Dim isoStore As IsolatedStorageFile = IsolatedStorageFile.GetStore(IsolatedStorageScope.User Or IsolatedStorageScope.Assembly, Nothing, Nothing)
        Dim FQN As String = UserID + ".Export.txt"
        Dim Msg As String = "GRID exported to: " + FQN
        Try
            'Dim sw As New StreamWriter(Server.MapPath("~/GridData.csv"), False)
            ' First we will write the headers.
            Dim dt As DataTable = DirectCast(DG.ItemsSource, DataSet).Tables(0)

            Using isoStream As IsolatedStorageFileStream = New IsolatedStorageFileStream(FQN, FileMode.Create, isoStore)
                Using writer As StreamWriter = New StreamWriter(isoStream)
                    writer.Write(result)
                End Using
            End Using
        Catch ex As Exception
            Msg = "ERROR: " + ex.Message
        End Try

        Return Msg
    End Function

    Public Shared Function ExportGridToHTML(DG As DataGrid, UserID As String) As String

        DG.ClipboardCopyMode = DataGridClipboardCopyMode.IncludeHeader
        Dim result As String = Clipboard.GetData(DataFormats.Html)

        Dim isoStore As IsolatedStorageFile = IsolatedStorageFile.GetStore(IsolatedStorageScope.User Or IsolatedStorageScope.Assembly, Nothing, Nothing)
        Dim FQN As String = UserID + ".Export.HTML"
        Dim Msg As String = "GRID exported to: " + FQN
        Try
            'Dim sw As New StreamWriter(Server.MapPath("~/GridData.csv"), False)
            ' First we will write the headers.
            Dim dt As DataTable = DirectCast(DG.ItemsSource, DataSet).Tables(0)

            Using isoStream As IsolatedStorageFileStream = New IsolatedStorageFileStream(FQN, FileMode.Create, isoStore)
                Using writer As StreamWriter = New StreamWriter(isoStream)
                    writer.Write(result)
                End Using
            End Using
        Catch ex As Exception
            Msg = "ERROR: " + ex.Message
        End Try

        Return Msg
    End Function

    Public Shared Function ExportGridToCSV(DG As DataGrid, UserID As String) As String

        DG.ClipboardCopyMode = DataGridClipboardCopyMode.IncludeHeader
        Dim result As String = Clipboard.GetData(DataFormats.CommaSeparatedValue)

        Dim isoStore As IsolatedStorageFile = IsolatedStorageFile.GetStore(IsolatedStorageScope.User Or IsolatedStorageScope.Assembly, Nothing, Nothing)
        Dim FQN As String = UserID + ".Export.csv"
        Dim Msg As String = "GRID exported to: " + FQN
        Try
            'Dim sw As New StreamWriter(Server.MapPath("~/GridData.csv"), False)
            ' First we will write the headers.
            Dim dt As DataTable = DirectCast(DG.ItemsSource, DataSet).Tables(0)

            Using isoStream As IsolatedStorageFileStream = New IsolatedStorageFileStream(FQN, FileMode.Create, isoStore)
                Using writer As StreamWriter = New StreamWriter(isoStream)
                    writer.Write(result)
                End Using
            End Using
        Catch ex As Exception
            Msg = "ERROR: " + ex.Message
        End Try

        Return Msg
    End Function

    Public Shared Function GetCell(dataGrid As DataGrid, rowContainer As DataGridRow, column As Integer) As DataGridCell
        If rowContainer IsNot Nothing Then
            Dim presenter As DataGridCellsPresenter = FindVisualChild(Of DataGridCellsPresenter)(rowContainer)
            If presenter Is Nothing Then
                ' if the row has been virtualized away, call its ApplyTemplate() method
                '             * to build its visual tree in order for the DataGridCellsPresenter
                '             * and the DataGridCells to be created
                rowContainer.ApplyTemplate()
                presenter = FindVisualChild(Of DataGridCellsPresenter)(rowContainer)
            End If
            If presenter IsNot Nothing Then
                Dim cell As DataGridCell = TryCast(presenter.ItemContainerGenerator.ContainerFromIndex(column), DataGridCell)
                If cell Is Nothing Then
                    ' bring the column into view in case it has been virtualized away
                    dataGrid.ScrollIntoView(rowContainer, dataGrid.Columns(column))
                    cell = TryCast(presenter.ItemContainerGenerator.ContainerFromIndex(column), DataGridCell)
                End If
                Return cell
            End If
        End If
        Return Nothing
    End Function

    Public Shared Function CreateDataTable(TableName As String, TableCols As Dictionary(Of String, String)) As DataTable

        Dim ColumnType As String = ""
        Dim dt As System.Data.DataTable = New DataTable(TableName)
        For Each sKey As String In TableCols.Keys
            sKey = sKey.ToString
            ColumnType = TableCols(sKey).ToUpper
            If ColumnType.Equals("USHORT") Then
                dt.Columns.Add(sKey, GetType(UShort))
            End If
            If ColumnType.Equals("UINT32") Then
                dt.Columns.Add(sKey, GetType(UInt32))
            End If
            If ColumnType.Equals("UINT64") Then
                dt.Columns.Add(sKey, GetType(UInt64))
            End If
            If ColumnType.Equals("UINTEGER") Then
                dt.Columns.Add(sKey, GetType(UInteger))
            End If
            If ColumnType.Equals("ULONG") Then
                dt.Columns.Add(sKey, GetType(ULong))
            End If
            If ColumnType.Equals("SINGLE") Then
                dt.Columns.Add(sKey, GetType(Single))
            End If
            If ColumnType.Equals("INT16") Then
                dt.Columns.Add(sKey, GetType(Int16))
            End If
            If ColumnType.Equals("SHORT") Then
                dt.Columns.Add(sKey, GetType(Short))
            End If
            If ColumnType.Equals("SBYTE") Then
                dt.Columns.Add(sKey, GetType(SByte))
            End If
            If ColumnType.Equals("OBJECT") Then
                dt.Columns.Add(sKey, GetType(Object))
            End If
            If ColumnType.Equals("DATETIME") Then
                dt.Columns.Add(sKey, GetType(DateTime))
            End If
            If ColumnType.Equals("DATE") Then
                dt.Columns.Add(sKey, GetType(Date))
            End If
            If ColumnType.Equals("CHAR") Then
                dt.Columns.Add(sKey, GetType(Char))
            End If
            If ColumnType.Equals("BOOLEAN") Then
                dt.Columns.Add(sKey, GetType(Boolean))
            End If
            If ColumnType.Equals("BYTE") Then
                dt.Columns.Add(sKey, GetType(Byte))
            End If
            If ColumnType.Equals("INTEGER") Then
                dt.Columns.Add(sKey, GetType(Integer))
            End If
            If ColumnType.Equals("LONG") Then
                dt.Columns.Add(sKey, GetType(Long))
            End If
            If ColumnType.Equals("INT32") Then
                dt.Columns.Add(sKey, GetType(Int32))
            End If
            If ColumnType.Equals("INT64") Then
                dt.Columns.Add(sKey, GetType(Int64))
            End If
            If ColumnType.Equals("DECIMAL") Then
                dt.Columns.Add(sKey, GetType(Decimal))
            End If
            If ColumnType.Equals("FLOAT") Then
                dt.Columns.Add(sKey, GetType(Double))
            End If
            If ColumnType.Equals("STRING") Then
                dt.Columns.Add(sKey, GetType(String))
            End If
        Next
        'dt.Rows.Add("row of data")
        Return dt
    End Function

End Class

Public Class tempdata
    Public name As String
    Public email As String
    Public age As Integer
    Public dec As Decimal

    Public Property dg_name()
        Get
            Return name
        End Get
        Set(ByVal value)
            name = value
        End Set
    End Property
    Public Property dg_email()
        Get
            Return email
        End Get
        Set(ByVal value)
            email = value
        End Set
    End Property
    Public Property dg_age()
        Get
            Return age
        End Get
        Set(ByVal value)
            age = value
        End Set
    End Property
    Public Property dg_decimal()
        Get
            Return dec
        End Get
        Set(ByVal value)
            dec = value
        End Set
    End Property
End Class