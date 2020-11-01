Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
'Imports System.Windows.Forms.DataGridView
Public Class clsDataGrid
    Inherits clsDatabaseARCH

    'Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma
    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging

    Dim SQL As New clsSql
    Dim iSequence_number As Integer = 0
    Dim iSHORT_REMARK As Integer = 1
    Dim iSTD_UNIT As Integer = 2
    Dim iEFFECTIVE_DATE As Integer = 3
    Dim iINEFFECTIVE_DATE As Integer = 4
    Dim iMeasurement_id As Integer = 5
    Dim iSkip As Integer = 6
    Dim iStd_component_id As Integer = 7
    Dim iShort_remark2 As Integer = 0
    Dim iEeffective_date2 As Integer = 1
    Dim iIneffective_date2 As Integer = 2
    Dim iMeasurement_id2 As Integer = 3
    Dim Sequence_number As String = ""
    Dim SHORT_REMARK As String = ""
    Dim STD_UNIT As String = ""
    Dim EFFECTIVE_DATE As String = ""
    Dim INEFFECTIVE_DATE As String = ""
    Dim Measurement_id As String = ""
    Dim Skip As String = ""
    Dim Std_component_id As String = ""
    Dim ComponentID As String = ""

    Function GetColValue(ByVal ColName As String, ByVal DG As DataGridView) As String
        Dim iRow As Integer = 0
        iRow = DG.CurrentRow.Index
        Dim S As String = DG.Item(ColName, iRow).Value.ToString
        Return S
    End Function
    Function iCol(ByVal ColName#, ByVal DG As DataGridView) As Integer
        Dim i As Integer = 0
        Dim j As Integer = 0
        If DG.Columns.Count > 0 Then
            j = DG.Columns.Count
            For i = 0 To j - 1
                'messagebox.show("Validate next stmt")
                Dim tColName As String = DG.Columns(i).ToString
                If StrComp(tColName, ColName, CompareMethod.Text) = 0 Then
                    Return i
                End If
            Next
        Else
            Return -1
        End If
        Return -1
    End Function
    Public Sub PopulateDataGrid(ByVal S As String, ByRef DG As DataGridView, ByRef dgColNames As String())
        Try
            Dim i As Integer = 0
            Dim dgKeys As String()
            Dim rsData As SqlDataReader = Nothing
            Dim b As Boolean = False
            Dim CS As String = setConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsData = command.ExecuteReader()
            If rsData Is Nothing Then
                Return
            End If
            Dim nbrCols As Integer = rsData.FieldCount
            ReDim dgColNames(nbrCols)
            If DG.Columns.Count > 0 Then
                DG.Columns.Clear()
            End If
            DG.Rows.Clear()
            For i = 0 To nbrCols - 1
                DG.Columns.Add(rsData.GetName(i).ToString, rsData.GetName(i).ToString)
                dgColNames(i) = rsData.GetName(i).ToString
            Next
            Dim II As Integer = nbrCols
            DG.Rows.Clear()
            If rsData.HasRows Then
                ReDim dgKeys(II)
                Dim ColNamesSet As Boolean = False
                Do While rsData.Read
                    For i = 0 To II - 1
                        dgKeys(i) = rsData.GetValue(i).ToString
                        If Not ColNamesSet Then
                            dgColNames(i) = rsData.GetName(i).ToString
                        End If
                    Next i
                    ColNamesSet = True
                    DG.Rows.Add(dgKeys)
                Loop
            End If
            'For i = 6 To II - 1
            '    DG.Columns(i).Visible = False
            'Next i
            rsData.Close()
            rsData = Nothing
        Catch ex As Exception
            LOG.WriteToArchiveLog("Error: clsDAtaGrid - PopulateDataGrid - 100:  " + ex.Message)
            LOG.WriteToArchiveLog("Error: clsDAtaGrid - PopulateDataGrid - 100:  " + ex.StackTrace)
            LOG.WriteToArchiveLog("Error: clsDAtaGrid - PopulateDataGrid - 100:  " + S)
        End Try

    End Sub
    Public Sub PopulateDataGrid(ByVal S As String, ByRef DG As DataGridView)
        Dim i As Integer = 0
        Dim dgKeys As String()
        Dim dgColNames As String()
        Dim rsData As SqlDataReader = Nothing
        Dim b As Boolean = False
        Dim CS As String = setConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsData = command.ExecuteReader()
        If rsData Is Nothing Then
            Return
        End If
        Dim nbrCols As Integer = rsData.FieldCount - 1
        ReDim dgColNames(nbrCols)
        If DG.Columns.Count > 0 Then
            DG.Columns.Clear()
        End If
        DG.Rows.Clear()
        For i = 0 To nbrCols - 1
            DG.Columns.Add(rsData.GetName(i).ToString, rsData.GetName(i).ToString)
            dgColNames(i) = rsData.GetName(i).ToString
        Next
        Dim II As Integer = nbrCols
        DG.Rows.Clear()
        If rsData.HasRows Then
            ReDim dgKeys(II)
            Dim ColNamesSet As Boolean = False
            Do While rsData.Read
                For i = 0 To II - 1
                    dgKeys(i) = rsData.GetValue(i).ToString
                    If Not ColNamesSet Then
                        dgColNames(i) = rsData.GetName(i).ToString
                    End If
                Next i
                ColNamesSet = True
                DG.Rows.Add(dgKeys)
            Loop
        End If
        'For i = 6 To II - 1
        '    DG.Columns(i).Visible = False
        'Next i
        rsData.Close()
        rsData = Nothing
    End Sub
    Public Sub PopulateColGrid(ByRef DG As DataGridView, ByVal TblID As String)
        Dim dgColNames As String()
        Dim rsdata As SqlDataReader = SQL.getAllColsSql(TblID)
        Dim i As Integer = 0
        Dim dgKeys As String()
        'Dim rsData As SqlDataReader = Nothing
        Dim b As Boolean = False
        'rsData = DBARCH.SqlQry(SQL, rsData)
        If rsdata Is Nothing Then
            Return
        End If
        Dim nbrCols As Integer = rsdata.FieldCount
        ReDim dgColNames(nbrCols)
        If DG.Columns.Count > 0 Then
            DG.Columns.Clear()
        End If
        For i = 0 To nbrCols - 1
            DG.Columns.Add(rsdata.GetName(i).ToString, rsdata.GetName(i).ToString)
            dgColNames(i) = rsdata.GetName(i).ToString
        Next
        Dim II As Integer = nbrCols
        DG.Rows.Clear()
        If rsdata.HasRows Then
            ReDim dgKeys(II)
            Dim ColNamesSet As Boolean = False
            Do While rsdata.Read
                For i = 0 To II - 1
                    dgKeys(i) = rsdata.GetValue(i).ToString
                    If Not ColNamesSet Then
                        dgColNames(i) = rsdata.GetName(i).ToString
                    End If
                Next i
                ColNamesSet = True
                DG.Rows.Add(dgKeys)
            Loop
        End If
        rsdata.Close()
        rsdata = Nothing
    End Sub
    'Public Sub AppendDataGrid(ByVal SQL , ByRef DG As DataGridView, ByVal ColCnt As Integer)
    '    Dim i As Integer = 0
    '    Dim dgKeys ()
    '    Dim rsData As SqlDataReader = Nothing
    '    Dim b As Boolean = False
    '    rsData = SqlQry(SQL, rsData)
    '    If rsData Is Nothing Then
    '        Return
    '    End If
    '    Dim nbrCols As Integer = rsData.FieldCount
    '    If nbrCols <> ColCnt Then
    '        Return
    '    End If
    '    Dim II As Integer = nbrCols
    '    If rsData.HasRows Then
    '        ReDim dgKeys(II)
    '        Dim ColNamesSet As Boolean = False
    '        Do While rsData.Read
    '            For i = 0 To II - 1
    '                dgKeys(i) = rsData.GetValue(i).ToString
    '            Next i
    '            DG.Rows.Add(dgKeys)
    '        Loop
    '    End If
    '    rsData.Close()
    '    rsData = Nothing
    'End Sub
    'Public Sub PopulateDataGrid(ByVal SQL , ByRef DG As DataGridView, ByRef dgColNames (), ByVal PB As ProgressBar)
    '    Dim i As Integer = 0
    '    Dim dgKeys ()
    '    Dim rsData As SqlDataReader = Nothing
    '    Dim b As Boolean = False
    '    Dim iCnt As Integer = iGetRowCount(SQL)
    '    PB.Minimum = 0
    '    PB.Maximum = iCnt + 5
    '    frmWorkInProgress.Show()
    '    frmWorkInProgress.PB.Minimum = 0
    '    frmWorkInProgress.PB.Maximum = iCnt + 5
    '    frmWorkInProgress.SB.Text = "Loading: " + DG.Name
    '    Dim iRow As Integer = DG.Rows.Count
    '    If iRow > 1 Then
    '        DG.Rows.Clear()
    '    End If
    '    rsData = SqlQry(SQL, rsData)
    '    Dim nbrCols As Integer = rsData.FieldCount
    '    ReDim dgColNames(nbrCols)
    '    DG.Columns.Clear()
    '    For i = 0 To nbrCols - 1
    '        DG.Columns.Add(rsData.GetName(i).ToString, rsData.GetName(i).ToString)
    '        dgColNames(i) = rsData.GetName(i).ToString
    '    Next
    '    Dim II As Integer = nbrCols
    '    If rsData.HasRows Then
    '        ReDim dgKeys(II)
    '        Dim kk As Integer = 0
    '        Dim ColNamesSet As Boolean = False
    '        Do While rsData.Read
    '            kk = kk + 1
    '            If kk Mod 5 = 0 Then
    '                frmWorkInProgress.PB.Value = kk
    '                PB.Value = kk
    '                PB.Refresh()
    '                System.Windows.Forms.Application.DoEvents()
    '            End If
    '            For i = 0 To II - 1
    '                dgKeys(i) = rsData.GetValue(i).ToString
    '                If Not ColNamesSet Then
    '                    dgColNames(i) = rsData.GetName(i).ToString
    '                End If
    '            Next i
    '            ColNamesSet = True
    '            DG.Rows.Add(dgKeys)
    '        Loop
    '    End If
    '    'For i = 6 To II - 1
    '    '    DG.Columns(i).Visible = False
    '    'Next i
    '    rsData.Close()
    '    rsData = Nothing
    '    PB.Value = 0
    '    frmWorkInProgress.Hide()
    'End Sub
    Public Sub DisplayColNames(ByRef DG As DataGridView)
        Dim i As Integer = 0
        For i = 0 To DG.Columns.Count - 1
            'Console.WriteLine("Column#" & i & " : " & DG.Columns(i).Name)
            Dim msg As String = "Column#" & i & " : " & DG.Columns(i).Name
            Debug.Print(msg)
        Next
    End Sub
    Public Sub DisplayColNames(ByRef DG As DataGridView, ByVal SL As SortedList)
        Dim i As Integer = 0
        Dim ColName As String = ""
        SL.Clear()
        For i = 0 To DG.Columns.Count - 1
            'Console.WriteLine("Column#" & i & " : " & DG.Columns(i).Name)
            Dim msg As String = "Column#" & i & " : " & DG.Columns(i).Name
            Debug.Print(msg)
            ColName = Mid(DG.Columns(i).Name, 1, 1)
            SL.Add(i, ColName)
        Next
    End Sub
    Sub ListColumnNames(ByVal dg As DataGridView)
        For Each column As DataGridViewColumn In dg.Columns
            Debug.Print(column.Name)
        Next
    End Sub
    Public Sub DisplayHeaderNames(ByRef DG As DataGridView)
        Dim i As Integer = 0
        For i = 0 To DG.Columns.Count - 1
            Dim msg As String = "Column#" & i & " : " & DG.Columns(i).Name
            Debug.Print(msg)
        Next
    End Sub
    'Public Sub AddGridColumns(ByRef DG As DataGridView, ByVal GridCols As String)
    '    Dim dgCols() As String = Split(GridCols, ",")
    '    Dim i As Integer = 0
    '    For i = 0 To UBound(dgCols) - 1
    '        DG.Columns.Add(dgCols(i), dgCols(i))
    '    Next
    '    Return
    'End Sub
    'Public Sub ZeroizeGridColumns(ByRef DG As DataGrid)
    '    'Dim dgCols() As String = Split(GridCols, ",")
    '    Dim i As Integer = 0
    '    Dim C As DataGridViewColumn
    '    For Each C In DG.Columns
    '        DG.Columns.Remove(C)
    '    Next
    '    Return
    'End Sub
    'Public Sub AddGridDataFromStr(ByRef DG As DataGridView, ByVal Str As String, ByVal Delimiter As String, ByVal bNewCols As Boolean)
    '    If Mid(Str, 1, 1) = Delimiter Then
    '        Mid(Str, 1, 1) = " "
    '    End If
    '    If Mid(Str, Len(Str), 1) = Delimiter Then
    '        Mid(Str, Len(Str), 1) = " "
    '    End If
    '    Str = Trim(Str)
    '    Dim cCnt As Integer = DG.ColumnCount
    '    If bNewCols Then
    '        Dim ii As Integer = 0
    '        Dim jj As Integer = 0
    '        Dim dgCols() As String = Split(Str, Delimiter)
    '        DG.Columns.Clear()
    '        For ii = 0 To UBound(dgCols)
    '            DG.Columns.Add(dgCols(ii), dgCols(ii))
    '        Next ii
    '    Else
    '        Dim dgKeys() As String = Split(Str, Delimiter)
    '        DG.Rows.Add(dgKeys)
    '    End If
    'End Sub
    Public Sub HideGridCol(ByRef DG As DataGridView, ByVal ColNbr As Integer)
        DG.Columns(ColNbr).Visible = False
    End Sub
    Public Sub SetGridColHeader(ByRef DG As DataGridView, ByVal ColNbr As Integer, ByVal ColTitle As String)
        DG.Columns(ColNbr).HeaderText = ColTitle
    End Sub
    Public Overloads Function PopulateGrid(ByVal SourceTable As String, ByVal MySql As String, ByRef DVG As DataGridView) As Integer
        'System.Windows.Forms.DataGridViewCellEventArgs
        Dim II As Integer = 0
        Try
            Dim BS As New BindingSource
            Dim CS As String = setConnStr()
            Dim sqlcn As New SqlConnection(CS)
            Dim sadapt As New SqlDataAdapter(MySql, sqlcn)
            Dim ds As DataSet = New DataSet
            If sqlcn.State = ConnectionState.Closed Then
                sqlcn.Open()
            End If
            sadapt.Fill(ds, SourceTable)
            II = ds.Tables(SourceTable).Rows.Count
            DVG.DataSource = ds.Tables(SourceTable)
        Catch ex As Exception
            'messagebox.show("Search Error 96165.4b: " + ex.Message + vbCrLf + MySql)
            II = -1
            LOG.WriteToArchiveLog("clsDataGrid : PopulateGrid : 96165.4b : " + ex.Message + vbCrLf + MySql)
        End Try
        Return II
    End Function
    Sub saveGridColOrder(ByVal G As DataGridView, ByVal F As Form)
        Dim I As Integer = 0
        Dim FormName As String = F.Name
        Dim ColName As String = ""

        Dim RUNPARMS As New clsRUNPARMS

        Try
            ColName = FormName + "|" + G.Name + "|" + " ColOrderActive"
            Dim iCnt As Integer = RUNPARMS.cnt_PKI8(ColName, gCurrUserGuidID)
            If iCnt = 0 Then
                RUNPARMS.setParmvalue("Y")
                RUNPARMS.setParm(ColName)
                RUNPARMS.setUserid(gCurrUserGuidID)
                RUNPARMS.Insert()
            End If
        Catch ex As Exception
            Console.WriteLine("saveGridColOrder Failed to set form grid active: " + ColName)
        End Try

        Dim iColCnt As Integer = G.ColumnCount
        Dim iDisplayIndex As Integer = 0
        For I = 0 To iColCnt - 1
            ColName = FormName + "|" + G.Name + "|" + G.Columns(I).Name
            iDisplayIndex = G.Columns(I).DisplayIndex
            Dim iCnt As Integer = RUNPARMS.cnt_PKI8(ColName, gCurrUserGuidID)
            If iCnt = 0 Then
                RUNPARMS.setParmvalue(iDisplayIndex.ToString)
                RUNPARMS.setParm(ColName)
                RUNPARMS.setUserid(gCurrUserGuidID)
                RUNPARMS.Insert()
            ElseIf iCnt > 0 Then
                RUNPARMS.setParmvalue(iDisplayIndex.ToString)
                RUNPARMS.setParm(ColName)
                RUNPARMS.setUserid(gCurrUserGuidID)
                Dim WC As String = RUNPARMS.wc_PKI8(ColName, gCurrUserGuidID)
                RUNPARMS.Update(WC)
            End If
        Next

        RUNPARMS = Nothing

        saveGridColWidth(G, F)

        GC.Collect()
        GC.WaitForFullGCComplete()

    End Sub

    Sub saveGridSortCol(ByVal G As DataGridView, ByVal F As Form, ByVal ColName As String, ByVal AscendingOrder As Boolean)

        Dim I As Integer = 0
        Dim FormName As String = F.Name
        Dim SortColName As String = ""
        Dim ColOrderNbr As Integer = -1

        For I = 0 To G.Columns.Count - 1
            Dim tgtCol As String = G.Columns(I).Name
            If tgtCol = ColName Then
                ColOrderNbr = I
                Exit For
            End If
        Next

        Dim RUNPARMS As New clsRUNPARMS
        Dim ParmName As String = ""
        Try
            SortColName = FormName + "|" + G.Name + "|" + ColName + "|" + ColOrderNbr.ToString + "|" + AscendingOrder.ToString
            ParmName = FormName + "|" + G.Name + "|" + "COLUMN_SORT"
            Dim iCnt As Integer = RUNPARMS.cnt_PKI8(ParmName, gCurrUserGuidID)
            If iCnt = 0 Then
                RUNPARMS.setParmvalue(SortColName)
                RUNPARMS.setParm(ParmName)
                RUNPARMS.setUserid(gCurrUserGuidID)
                RUNPARMS.Insert()
            Else
                Dim WC As String = RUNPARMS.wc_PKI8(ParmName, gCurrUserGuidID)
                RUNPARMS.setParmvalue(SortColName)
                RUNPARMS.setParm(ParmName)
                RUNPARMS.setUserid(gCurrUserGuidID)
                RUNPARMS.Update(WC)
            End If
        Catch ex As Exception
            Console.WriteLine("saveGridSortCol Failed to set form grid sort: " + ColName)
        End Try

        RUNPARMS = Nothing

        GC.Collect()
        GC.WaitForFullGCComplete()

    End Sub
    Sub getGridSortCol(ByRef G As DataGridView, ByVal F As Form)


        'SortColName  = FormName + "|" + G.Name + "|" + "Sort" + "|" + ColName  + "|" + ColOrderNbr.ToString + "|" + AscendingOrder.ToString
        Dim tFormName As String = ""
        Dim tGridName As String = ""
        Dim tColOrderNbr As Integer = -1
        Dim tAscendingOrder As String = ""
        Dim tColName As String = ""

        Dim ParmName As String = F.Name + "|" + G.Name + "|" + "COLUMN_SORT"

        Dim I As Integer = 0
        Dim FormName As String = F.Name
        Dim Parm As String = ""

        Dim bSetOrder As Boolean = False

        Dim GridOrder As New SortedList(Of Integer, String)
        Dim RUNPARMS As New clsRUNPARMS
        Dim iCnt As Integer = RUNPARMS.cnt_PKI8(ParmName, gCurrUserGuidID)

        If iCnt = 1 Then
            Dim WC As String = RUNPARMS.wc_PKI8(ParmName, gCurrUserGuidID)
            Dim RS As SqlDataReader
            RS = RUNPARMS.SelectOne(WC)
            If RS.HasRows Then
                RS.Read()
                Parm = RS.GetValue(0).ToString
                Dim ParmValue As String = RS.GetValue(1).ToString
                Dim UserID As String = RS.GetValue(2).ToString
                If InStr(ParmValue, "|") > 0 Then
                    bSetOrder = True
                    'SortColName  = FormName + "|" + G.Name + "|" + ColName  + "|" + ColOrderNbr.ToString + "|" + AscendingOrder.ToString
                    Dim A As String() = ParmValue.Split("|")
                    tFormName = A(0)
                    tGridName = A(1)
                    tColName = A(2)
                    tColOrderNbr = Val(A(3))
                    tAscendingOrder = A(4)
                End If
            End If
        End If



        RUNPARMS = Nothing

        If bSetOrder = True Then
            Dim ColOrderNbr As Integer = -1
            For I = 0 To G.Columns.Count - 1
                Dim tgtCol As String = G.Columns(I).Name
                If tgtCol.ToUpper.Equals(tColName.ToUpper) Then
                    ColOrderNbr = I
                    Exit For
                End If
            Next

            Dim DGVC As System.Windows.Forms.DataGridViewColumn = G.Columns(ColOrderNbr)
            If tAscendingOrder.ToUpper.Equals("TRUE") Then
                G.Sort(DGVC, ComponentModel.ListSortDirection.Ascending)
            Else
                G.Sort(DGVC, ComponentModel.ListSortDirection.Descending)
            End If
            G.Refresh()
        End If

        GC.Collect()
        GC.WaitForFullGCComplete()

    End Sub

    Sub saveGridColWidth(ByVal G As DataGridView, ByVal F As Form)
        Dim I As Integer = 0
        Dim FormName As String = F.Name
        Dim ColName As String = ""

        Dim RUNPARMS As New clsRUNPARMS
        Dim iColCnt As Integer = G.ColumnCount
        Dim iWidth As Integer = 0

        For I = 0 To iColCnt - 1
            ColName = FormName + "|" + G.Name + "|" + "Width|" + G.Columns(I).Name
            iWidth = G.Columns(I).Width
            Dim iCnt As Integer = RUNPARMS.cnt_PKI8(ColName, gCurrUserGuidID)
            If iCnt = 0 Then
                RUNPARMS.setParmvalue(iWidth.ToString)
                RUNPARMS.setParm(ColName)
                RUNPARMS.setUserid(gCurrUserGuidID)
                RUNPARMS.Insert()
            ElseIf iCnt > 0 Then
                RUNPARMS.setParmvalue(iWidth.ToString)
                RUNPARMS.setParm(ColName)
                RUNPARMS.setUserid(gCurrUserGuidID)
                Dim WC As String = RUNPARMS.wc_PKI8(ColName, gCurrUserGuidID)
                RUNPARMS.Update(WC)
            End If
        Next

        RUNPARMS = Nothing

        GC.Collect()
        GC.WaitForFullGCComplete()

    End Sub
    Function isGridColOrderActive(ByRef G As DataGridView, ByVal F As Form) As Boolean
        Dim isActive As Boolean = False
        Dim I As Integer = 0
        Dim FormName As String = F.Name
        Dim ColName As String = ""

        Dim RUNPARMS As New clsRUNPARMS

        Try
            ColName = FormName + "|" + G.Name + "|" + " ColOrderActive"
            Dim iCnt As Integer = RUNPARMS.cnt_PKI8(ColName, gCurrUserGuidID)
            If iCnt = 1 Then
                Dim WC As String = RUNPARMS.wc_PKI8(ColName, gCurrUserGuidID)
                Dim RS As SqlDataReader
                RS = RUNPARMS.SelectOne(WC)
                If RS.HasRows Then
                    Do While RS.Read()
                        Dim Parm As String = RS.GetValue(0).ToString
                        Dim ParmValue As String = RS.GetValue(1).ToString
                        Dim UserID As String = RS.GetValue(0).ToString
                        Dim iColOrder As Integer = Val(ParmValue)
                        If ParmValue.Equals("Y") Or ParmValue.Equals("1") Then
                            isActive = True
                        Else
                            isActive = False
                        End If
                    Loop
                End If
            End If
        Catch ex As Exception
            Console.WriteLine("isGridColOrderActive Failed to set form grid avtive: " + ColName)
        End Try
        RUNPARMS = Nothing

        GC.Collect()
        GC.WaitForFullGCComplete()

        Return isActive
    End Function
    Sub getGridColOrder(ByRef G As DataGridView, ByVal F As Form)

        If isGridColOrderActive(G, F) = False Then
            Return
        End If

        Dim I As Integer = 0
        Dim FormName As String = F.Name
        Dim ColName As String = ""

        Dim GridOrder As New SortedList(Of Integer, String)
        Dim RUNPARMS As New clsRUNPARMS

        Dim iColCnt As Integer = G.ColumnCount

        For I = 0 To iColCnt - 1
            ColName = FormName + "|" + G.Name + "|" + G.Columns(I).Name
            Dim iCnt As Integer = RUNPARMS.cnt_PKI8(ColName, gCurrUserGuidID)
            If iCnt = 1 Then
                Dim WC As String = RUNPARMS.wc_PKI8(ColName, gCurrUserGuidID)
                Dim RS As SqlDataReader
                RS = RUNPARMS.SelectOne(WC)
                If RS.HasRows Then
                    Do While RS.Read()
                        Dim Parm As String = RS.GetValue(0).ToString
                        Dim ParmValue As String = RS.GetValue(1).ToString
                        Dim UserID As String = RS.GetValue(0).ToString
                        Dim iColOrder As Integer = Val(ParmValue)
                        If GridOrder.ContainsKey(iColOrder) Then
                        Else
                            GridOrder.Add(iColOrder, G.Columns(I).Name)
                        End If
                    Loop
                End If
            End If
        Next

        For I = 0 To GridOrder.Count - 1
            ColName = GridOrder.Values(I)
            G.Columns(ColName).DisplayIndex = I
        Next
        RUNPARMS = Nothing

        getGridColWidth(G, F)

        G.Refresh()

        GC.Collect()
        GC.WaitForFullGCComplete()

    End Sub
    Sub getGridColWidth(ByRef G As DataGridView, ByVal F As Form)

        If isGridColOrderActive(G, F) = False Then
            Return
        End If

        Dim I As Integer = 0
        Dim FormName As String = F.Name
        Dim ColName As String = ""

        Dim GridWidth As New SortedList(Of String, Integer)
        Dim RUNPARMS As New clsRUNPARMS

        Dim iColCnt As Integer = G.ColumnCount

        For I = 0 To iColCnt - 1
            ColName = FormName + "|" + G.Name + "|" + "Width|" + G.Columns(I).Name
            Dim iCnt As Integer = RUNPARMS.cnt_PKI8(ColName, gCurrUserGuidID)
            If iCnt = 1 Then
                Dim WC As String = RUNPARMS.wc_PKI8(ColName, gCurrUserGuidID)
                Dim RS As SqlDataReader
                RS = RUNPARMS.SelectOne(WC)
                If RS.HasRows Then
                    Do While RS.Read()
                        Dim Parm As String = RS.GetValue(0).ToString
                        Dim ParmValue As String = RS.GetValue(1).ToString
                        Dim UserID As String = RS.GetValue(0).ToString
                        Dim iColOrder As Integer = Val(ParmValue)
                        If GridWidth.ContainsKey(ColName) Then
                        Else
                            GridWidth.Add(ColName, Val(ParmValue))
                        End If
                    Loop
                End If
            End If
        Next

        For Each S As String In GridWidth.Keys
            ColName = S.ToString
            Dim iKey As Integer = GridWidth.IndexOfKey(ColName)
            Dim ColWidth As Integer = GridWidth.Values(iKey)
            Dim A(0) As String
            A = ColName.Split("|")
            Dim tColName As String = A(UBound(A))
            Try
                G.Columns(tColName).Width = ColWidth
            Catch ex As Exception
                G.Columns(tColName).Width = 100
            End Try

        Next
        RUNPARMS = Nothing

        G.Refresh()

        GC.Collect()
        GC.WaitForFullGCComplete()

    End Sub

    Sub removeGridColOrder(ByRef G As DataGridView, ByVal F As Form)
        Dim I As Integer = 0
        Dim FormName As String = F.Name
        Dim ColName As String = ""

        Dim GridOrder As New SortedList(Of Integer, String)
        Dim RUNPARMS As New clsRUNPARMS

        Dim iColCnt As Integer = G.ColumnCount

        For I = 0 To iColCnt - 1
            ColName = FormName + "|" + G.Name + "|" + G.Columns(I).Name
            Dim iCnt As Integer = RUNPARMS.cnt_PKI8(ColName, gCurrUserGuidID)
            If iCnt = 1 Then
                Dim WC As String = RUNPARMS.wc_PKI8(ColName, gCurrUserGuidID)
                RUNPARMS.Delete(WC)
            End If
        Next

        RUNPARMS = Nothing
        G.Refresh()
        GC.Collect()
        GC.WaitForFullGCComplete()

        setDefaultGridColOrder(G, F)

    End Sub
    Sub setDefaultGridColOrder(ByVal G As DataGridView, ByVal F As Form)
        Dim I As Integer = 0
        Dim FormName As String = F.Name
        Dim ColName As String = ""

        Dim RUNPARMS As New clsRUNPARMS

        Try
            ColName = FormName + "|" + G.Name + "|" + " ColOrderActive"
            Dim iCnt As Integer = RUNPARMS.cnt_PKI8(ColName, gCurrUserGuidID)
            If iCnt = 0 Then
                RUNPARMS.setParmvalue("N")
                RUNPARMS.setParm(ColName)
                RUNPARMS.setUserid(gCurrUserGuidID)
                RUNPARMS.Insert()
            End If
        Catch ex As Exception
            Console.WriteLine("saveGridColOrder Failed to set form grid avtive: " + ColName)
        End Try

        Dim iColCnt As Integer = G.ColumnCount
        Dim iDisplayIndex As Integer = 0
        For I = 0 To iColCnt - 1
            G.Columns(I).DisplayIndex = 9
            'ColName = FormName + "|" + G.Name + "|" + G.Columns(I).Name
            'iDisplayIndex = I
            'Dim iCnt As Integer = RUNPARMS.cnt_PKI8(ColName, gCurrUserGuidID)
            'If iCnt = 0 Then
            '    RUNPARMS.setParmvalue(iDisplayIndex.ToString)
            '    RUNPARMS.setParm(ColName)
            '    RUNPARMS.setUserid(gCurrUserGuidID)
            '    RUNPARMS.Insert()
            'ElseIf iCnt > 0 Then
            '    RUNPARMS.setParmvalue(iDisplayIndex.ToString)
            '    RUNPARMS.setParm(ColName)
            '    RUNPARMS.setUserid(gCurrUserGuidID)
            '    Dim WC  = RUNPARMS.wc_PKI8(ColName, gCurrUserGuidID)
            '    RUNPARMS.Update(WC)
            'End If
        Next

        RUNPARMS = Nothing
        G.Refresh()
        GC.Collect()
        GC.WaitForFullGCComplete()

    End Sub
End Class

