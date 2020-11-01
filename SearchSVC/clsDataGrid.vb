Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections



'Imports System.Windows.Forms.DataGridView
Public Class clsDataGrid
    Inherits clsDatabaseSVR

    'Dim DB As New clsDatabase
    Dim DMA As New clsDmaSVR
    Dim UTIL As New clsUtilitySVR
    Dim LOG As New clsLogging

    Dim SQL As New clsSqlSVR
    'Dim SQL As New EcmQryGen.clsSql

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
    Dim Sequence_number as string = ""
    Dim SHORT_REMARK as string = ""
    Dim STD_UNIT as string = ""
    Dim EFFECTIVE_DATE as string = ""
    Dim INEFFECTIVE_DATE as string = ""
    Dim Measurement_id as string = ""
    Dim Skip as string = ""
    Dim Std_component_id as string = ""
    Dim ComponentID as string = ""


    Dim SecureID As Integer = -1

    Sub New(ByVal iSecureID As Integer)
        SecureID = iSecureID
    End Sub

    'Function GetColValue(ByVal ColName as string, byref GridName As String) As String
    '    Dim iRow As Integer = 0
    '    iRow = DG.CurrentRow.Index
    '    Dim S$ = DG.Item(ColName, iRow).Value.ToString
    '    Return S
    'End Function

    'Function iCol(ByVal ColName#, ByRef GridName As String) As Integer
    '    Dim i As Integer = 0
    '    Dim j As Integer = 0
    '    If DG.Columns.Count > 0 Then
    '        j = DG.Columns.Count
    '        For i = 0 To j - 1
    '            'MsgBox("Validate next stmt")
    '            Dim tColName$ = DG.Columns(i).ToString
    '            If StrComp(tColName, ColName, CompareMethod.Text) = 0 Then
    '                Return i
    '            End If
    '        Next
    '    Else
    '        Return -1
    '    End If
    '    Return -1
    'End Function
    'Public Sub PopulateDataGrid(ByVal S As String, ByRef GridName As String, ByRef dgColNames As List(Of String))
    '    Try
    '        Dim i As Integer = 0
    '        Dim dgKeys$()
    '        Dim rsData As SqlDataReader = Nothing
    '        Dim b As Boolean = false
    '        Dim CS$ = DBgetConnStr(SecureID,"CSREPO") : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsData = command.ExecuteReader()
    '        If rsData Is Nothing Then
    '            Return
    '        End If
    '        Dim nbrCols As Integer = rsData.FieldCount
    '        If nbrCols > 0 Then
    '            dgColNames.Clear()
    '        End If
    '        DG.Rows.Clear()
    '        For i = 0 To nbrCols - 1
    '            DG.Columns.Add(rsData.GetName(i).ToString, rsData.GetName(i).ToString)
    '            dgColNames(i) = rsData.GetName(i).ToString
    '        Next
    '        Dim II As Integer = nbrCols
    '        DG.Rows.Clear()
    '        If rsData.HasRows Then
    '            ReDim dgKeys(II)
    '            Dim ColNamesSet As Boolean = false
    '            Do While rsData.Read
    '                For i = 0 To II - 1
    '                    dgKeys(i) = rsData.GetValue(i).ToString
    '                    If Not ColNamesSet Then
    '                        dgColNames(i) = rsData.GetName(i).ToString
    '                    End If
    '                Next i
    '                ColNamesSet = True
    '                DG.Rows.Add(dgKeys)
    '            Loop
    '        End If
    '        'For i = 6 To II - 1
    '        '    DG.Columns(i).Visible = false
    '        'Next i
    '        rsData.Close()
    '        rsData = Nothing
    '    Catch ex As Exception
    '        LOG.WriteToSqlLog("Error: clsDAtaGrid - PopulateDataGrid - 100:  " + ex.Message)
    '        LOG.WriteToSqlLog("Error: clsDAtaGrid - PopulateDataGrid - 100:  " + ex.StackTrace)
    '        LOG.WriteToSqlLog("Error: clsDAtaGrid - PopulateDataGrid - 100:  " + S)
    '    End Try

    'End Sub
    'Public Sub PopulateDataGrid(ByVal S as string, byref GridName As String)
    '    Dim i As Integer = 0
    '    Dim dgKeys$()
    '    Dim dgColNames$()
    '    Dim rsData As SqlDataReader = Nothing
    '    Dim b As Boolean = false
    '    Dim CS$ = DBgetConnStr(SecureID,"CSREPO") : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsData = command.ExecuteReader()
    '    If rsData Is Nothing Then
    '        Return
    '    End If
    '    Dim nbrCols As Integer = rsData.FieldCount - 1
    '    ReDim dgColNames(nbrCols)
    '    If DG.Columns.Count > 0 Then
    '        DG.Columns.Clear()
    '    End If
    '    DG.Rows.Clear()
    '    For i = 0 To nbrCols - 1
    '        DG.Columns.Add(rsData.GetName(i).ToString, rsData.GetName(i).ToString)
    '        dgColNames(i) = rsData.GetName(i).ToString
    '    Next
    '    Dim II As Integer = nbrCols
    '    DG.Rows.Clear()
    '    If rsData.HasRows Then
    '        ReDim dgKeys(II)
    '        Dim ColNamesSet As Boolean = false
    '        Do While rsData.Read
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
    '    '    DG.Columns(i).Visible = false
    '    'Next i
    '    rsData.Close()
    '    rsData = Nothing
    'End Sub
    'Public Sub PopulateColGrid(ByRef GridName As String, ByVal TblID as string)
    '    Dim dgColNames$()
    '    Dim rsdata As SqlDataReader = SQL.getAllColsSql(TblID as string)
    '    Dim i As Integer = 0
    '    Dim dgKeys$()
    '    'Dim rsData As SqlDataReader = Nothing
    '    Dim b As Boolean = false
    '    'rsData = DB.SqlQry(SQL, rsData)
    '    If rsdata Is Nothing Then
    '        Return
    '    End If
    '    Dim nbrCols As Integer = rsdata.FieldCount
    '    ReDim dgColNames(nbrCols)
    '    If DG.Columns.Count > 0 Then
    '        DG.Columns.Clear()
    '    End If
    '    For i = 0 To nbrCols - 1
    '        DG.Columns.Add(rsdata.GetName(i).ToString, rsdata.GetName(i).ToString)
    '        dgColNames(i) = rsdata.GetName(i).ToString
    '    Next
    '    Dim II As Integer = nbrCols
    '    DG.Rows.Clear()
    '    If rsdata.HasRows Then
    '        ReDim dgKeys(II)
    '        Dim ColNamesSet As Boolean = false
    '        Do While rsdata.Read
    '            For i = 0 To II - 1
    '                dgKeys(i) = rsdata.GetValue(i).ToString
    '                If Not ColNamesSet Then
    '                    dgColNames(i) = rsdata.GetName(i).ToString
    '                End If
    '            Next i
    '            ColNamesSet = True
    '            DG.Rows.Add(dgKeys)
    '        Loop
    '    End If
    '    rsdata.Close()
    '    rsdata = Nothing
    'End Sub
    'Public Sub AppendDataGrid(ByVal SQL as string, byref  GridName As String, ByVal ColCnt As Integer)
    '    Dim i As Integer = 0
    '    Dim dgKeys$()
    '    Dim rsData As SqlDataReader = Nothing
    '    Dim b As Boolean = false
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
    '        Dim ColNamesSet As Boolean = false
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
    'Public Sub PopulateDataGrid(ByVal SQL as string, byref  GridName As String, ByRef dgColNames$(), ByVal PB As ProgressBar)
    '    Dim i As Integer = 0
    '    Dim dgKeys$()
    '    Dim rsData As SqlDataReader = Nothing
    '    Dim b As Boolean = false
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
    '        Dim ColNamesSet As Boolean = false
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
    '    '    DG.Columns(i).Visible = false
    '    'Next i
    '    rsData.Close()
    '    rsData = Nothing
    '    PB.Value = 0
    '    frmWorkInProgress.Hide()
    'End Sub

    'Public Sub DisplayColNames(ByRef GridName As String)
    '    Dim i As Integer = 0
    '    For i = 0 To DG.Columns.Count - 1
    '        'Console.WriteLine("Column#" & i & " : " & DG.Columns(i).Name)
    '        Dim msg$ = "Column#" & i & " : " & DG.Columns(i).Name
    '        Debug.Print(msg)
    '    Next
    'End Sub

    'Public Sub DisplayColNames(ByRef GridName As String, ByVal SL As SortedList)
    '    Dim i As Integer = 0
    '    Dim ColName As String = ""
    '    SL.Clear()
    '    For i = 0 To DG.Columns.Count - 1
    '        'Console.WriteLine("Column#" & i & " : " & DG.Columns(i).Name)
    '        Dim msg$ = "Column#" & i & " : " & DG.Columns(i).Name
    '        Debug.Print(msg)
    '        ColName = Mid(DG.Columns(i).Name, 1, 1)
    '        SL.Add(i, ColName)
    '    Next
    'End Sub

    'Sub ListColumnNames(ByRef GridName As String)
    '    For Each column As DataGridViewColumn In dg.Columns
    '        Debug.Print(column.Name)
    '    Next
    'End Sub

    'Public Sub DisplayHeaderNames(ByRef GridName As String)
    '    Dim i As Integer = 0
    '    For i = 0 To DG.Columns.Count - 1
    '        Dim msg$ = "Column#" & i & " : " & DG.Columns(i).Name
    '        Debug.Print(msg)
    '    Next
    'End Sub

    'Public Sub AddGridColumns(ByRef  GridName As String, ByVal GridCols As String)
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
    'Public Sub AddGridDataFromStr(ByRef  GridName As String, ByVal Str As String, ByVal Delimiter As String, ByVal bNewCols As Boolean)
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
    'Public Sub HideGridCol(ByRef GridName As String, ByVal ColNbr As Integer)
    '    DG.Columns(ColNbr).Visible = false
    'End Sub
    'Public Sub SetGridColHeader(ByRef GridName As String, ByVal ColNbr As Integer, ByVal ColTitle as string)
    '    DG.Columns(ColNbr).HeaderText = ColTitle
    'End Sub
    'Public Function PopulateGrid(ByVal SourceTable As String, ByVal MySql As String, ByRef GridName As String) As Integer
    '    'System.Windows.Forms.DataGridViewCellEventArgs
    '    Dim II As Integer = 0
    '    Try
    '        Dim BS As New BindingSource
    '        Dim CS$ = DBgetConnStr(SecureID,"CSREPO")
    '        Dim sqlcn As New SqlConnection(CS)
    '        Dim sadapt As New SqlDataAdapter(MySql, sqlcn)
    '        Dim ds As DataSet = New DataSet
    '        If sqlcn.State = ConnectionState.Closed Then
    '            sqlcn.Open()
    '        End If
    '        sadapt.Fill(ds, SourceTable as string)
    '        II = ds.Tables(SourceTable as string).Rows.Count
    '        DVG.DataSource = ds.Tables(SourceTable as string)
    '    Catch ex As Exception
    '        'MsgBox("Search Error 96165.4b: " + ex.Message + vbCrLf + MySql)
    '        II = -1
    '        LOG.WriteToSqlLog("clsDataGrid : PopulateGrid : 96165.4b : " + ex.Message + vbCrLf + MySql)
    '    End Try
    '    Return II
    'End Function
    Sub saveGridColOrder(ByVal FormName As String, ByVal GridName As String, ByVal ColumnNames As List(Of String), ByVal ColumnWidths() As Integer)
        Dim I As Integer = 0
        Dim ColName As String = ""

        Dim RUNPARMS As New clsRUNPARMS(SecureID)

        Try
            ColName = FormName + "|" + GridName + "|" + "$ColOrderActive"
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

        Dim iColCnt As Integer = ColumnNames.Count
        Dim iDisplayIndex As Integer = 0
        For I = 0 To iColCnt - 1
            ColName = FormName + "|" + GridName + "|" + ColumnNames(I)
            iDisplayIndex = ColumnNames(I)
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
                Dim WC$ = RUNPARMS.wc_PKI8(ColName, gCurrUserGuidID)
                RUNPARMS.Update(WC)
            End If
        Next

        RUNPARMS = Nothing

        saveGridColWidth(GridName, FormName, ColumnNames, ColumnWidths)

        GC.Collect()
        GC.WaitForFullGCComplete()

    End Sub

    Sub saveGridSortCol(ByVal GridName As String, ByVal FormName As String, ByVal ColName as string, byval ColOrderNbr As Integer, ByVal AscendingOrder As Boolean)

        Dim I As Integer = 0
        Dim SortColName as string = ""
        'Dim ColOrderNbr As Integer = -1

        'For I = 0 To G.Columns.Count - 1
        '    Dim tgtCol$ = ColumnNames(i)
        '    If tgtCol = ColName Then
        '        ColOrderNbr = I
        '        Exit For
        '    End If
        'Next

        Dim RUNPARMS As New clsRUNPARMS(SecureID)
        Dim ParmName as string = ""
        Try
            SortColName$ = FormName + "|" + GridName + "|" + ColName$ + "|" + ColOrderNbr.ToString + "|" + AscendingOrder.ToString
            ParmName = FormName + "|" + GridName + "|" + "COLUMN_SORT"
            Dim iCnt As Integer = RUNPARMS.cnt_PKI8(ParmName, gCurrUserGuidID)
            If iCnt = 0 Then
                RUNPARMS.setParmvalue(SortColName)
                RUNPARMS.setParm(ParmName)
                RUNPARMS.setUserid(gCurrUserGuidID)
                RUNPARMS.Insert()
            Else
                Dim WC$ = RUNPARMS.wc_PKI8(ParmName, gCurrUserGuidID)
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
    Sub getGridSortCol(ByRef bSetOrder As Boolean, ByVal GridName As String, ByVal FormName As String)

        'SortColName$ = FormName + "|" + GridName + "|" + "Sort" + "|" + ColName$ + "|" + ColOrderNbr.ToString + "|" + AscendingOrder.ToString
        Dim tFormName as string = ""
        Dim tGridName as string = ""
        Dim tColOrderNbr As Integer = -1
        Dim tAscendingOrder as string = ""
        Dim tColName as string = ""

        Dim ParmName$ = FormName + "|" + GridName + "|" + "COLUMN_SORT"

        Dim I As Integer = 0
        Dim Parm as string = ""

        Dim GridOrder As New SortedList(Of Integer, String)
        Dim RUNPARMS As New clsRUNPARMS(SecureID)
        Dim iCnt As Integer = RUNPARMS.cnt_PKI8(ParmName$, gCurrUserGuidID)

        If iCnt = 1 Then
            Dim WC$ = RUNPARMS.wc_PKI8(ParmName$, gCurrUserGuidID)
            Dim RS As SqlDataReader
            RS = RUNPARMS.SelectOne(SecureID, WC)
            If RS.HasRows Then
                RS.Read()
                Parm$ = RS.GetValue(0).ToString
                Dim ParmValue$ = RS.GetValue(1).ToString
                Dim UserID$ = RS.GetValue(2).ToString
                If InStr(ParmValue, "|") > 0 Then
                    bSetOrder = True
                    'SortColName$ = FormName + "|" + GridName + "|" + ColName$ + "|" + ColOrderNbr.ToString + "|" + AscendingOrder.ToString
                    Dim A$() = ParmValue.Split("|")
                    tFormName$ = A(0)
                    tGridName$ = A(1)
                    tColName = A(2)
                    tColOrderNbr = Val(A(3))
                    tAscendingOrder$ = A(4)
                End If
            End If
        End If



        RUNPARMS = Nothing

        'If bSetOrder = True Then
        '    Dim ColOrderNbr As Integer = -1
        '    For I = 0 To G.Columns.Count - 1
        '        Dim tgtCol$ = ColumnNames(i)
        '        If tgtCol.ToUpper.Equals(tColName.ToUpper) Then
        '            ColOrderNbr = I
        '            Exit For
        '        End If
        '    Next

        '    Dim DGVC As System.Windows.Forms.DataGridViewColumn = G.Columns(ColOrderNbr)
        '    If tAscendingOrder$.ToUpper.Equals("TRUE") Then
        '        G.Sort(DGVC, ComponentModel.ListSortDirection.Ascending)
        '    Else
        '        G.Sort(DGVC, ComponentModel.ListSortDirection.Descending)
        '    End If
        '    G.Refresh()
        'End If

        GC.Collect()
        GC.WaitForFullGCComplete()

    End Sub

    Sub saveGridColWidth(ByVal GridName As String, ByVal FormName As String, ByVal ColumnNames As List(Of String), ByVal ColWidths() As Integer)
        Dim I As Integer = 0
        Dim ColName As String = ""

        Dim RUNPARMS As New clsRUNPARMS(SecureID)
        Dim iColCnt As Integer = ColumnNames.Count
        Dim iWidth As Integer = 0

        For I = 0 To iColCnt - 1
            ColName = FormName + "|" + GridName + "|" + "Width|" + ColumnNames(I)
            iWidth = ColWidths(I)
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
                Dim WC$ = RUNPARMS.wc_PKI8(ColName, gCurrUserGuidID)
                RUNPARMS.Update(WC)
            End If
        Next

        RUNPARMS = Nothing

        GC.Collect()
        GC.WaitForFullGCComplete()

    End Sub
    Function isGridColOrderActive(ByRef GridName As String, ByVal FormName As String) As Boolean
        Dim isActive As Boolean = false
        Dim I As Integer = 0
        Dim ColName As String = ""

        Dim RUNPARMS As New clsRUNPARMS(SecureID)

        Try
            ColName = FormName + "|" + GridName + "|" + "$ColOrderActive"
            Dim iCnt As Integer = RUNPARMS.cnt_PKI8(ColName, gCurrUserGuidID)
            If iCnt = 1 Then
                Dim WC$ = RUNPARMS.wc_PKI8(ColName, gCurrUserGuidID)
                Dim RS As SqlDataReader
                RS = RUNPARMS.SelectOne(SecureID, WC)
                If RS.HasRows Then
                    Do While RS.Read()
                        Dim Parm$ = RS.GetValue(0).ToString
                        Dim ParmValue$ = RS.GetValue(1).ToString
                        Dim UserID$ = RS.GetValue(0).ToString
                        Dim iColOrder As Integer = Val(ParmValue)
                        If ParmValue$.Equals("Y") Or ParmValue$.Equals("1") Then
                            isActive = True
                        Else
                            isActive = false
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
    Sub getGridColOrder(ByRef GridName As String, ByVal FormName As String, ByVal ColumnNames As List(Of String), ByRef ColumnWidths As List(Of Integer), ByVal ColumnDisplayOrder As List(Of Integer))

        If isGridColOrderActive(GridName, FormName) = false Then
            Return
        End If

        Dim I As Integer = 0
        Dim ColName As String = ""

        Dim GridOrder As New SortedList(Of Integer, Integer)
        Dim RUNPARMS As New clsRUNPARMS(SecureID)

        Dim iColCnt As Integer = ColumnNames.Count

        For I = 0 To iColCnt - 1
            ColName = FormName + "|" + GridName + "|" + ColumnNames(I)
            Dim iCnt As Integer = RUNPARMS.cnt_PKI8(ColName, gCurrUserGuidID)
            If iCnt = 1 Then
                Dim WC$ = RUNPARMS.wc_PKI8(ColName, gCurrUserGuidID)
                Dim RS As SqlDataReader
                RS = RUNPARMS.SelectOne(SecureID, WC)
                If RS.HasRows Then
                    Do While RS.Read()
                        Dim Parm$ = RS.GetValue(0).ToString
                        Dim ParmValue$ = RS.GetValue(1).ToString
                        Dim UserID$ = RS.GetValue(0).ToString
                        Dim iColOrder As Integer = Val(ParmValue)
                        If GridOrder.ContainsKey(iColOrder) Then
                        Else
                            GridOrder.Add(I, iColOrder)
                        End If
                    Loop
                End If
            End If
        Next

        For I = 0 To GridOrder.Count - 1
            Dim iOrder As Integer = GridOrder.Values(I)
            'G.Columns(ColName).DisplayIndex = I
            ColumnDisplayOrder.Add(iOrder)
        Next
        RUNPARMS = Nothing

        getGridColWidth(GridName, FormName, ColumnNames, ColumnWidths)

        GC.Collect()
        GC.WaitForFullGCComplete()

    End Sub
    Sub getGridColWidth(ByRef GridName As String, ByVal FormName As String, ByVal ColumnNames As List(Of String), ByVal ColumnWidths As List(Of Integer))

        If isGridColOrderActive(GridName, FormName) = false Then
            Return
        End If

        Dim I As Integer = 0
        Dim ColName As String = ""

        Dim GridWidth As New SortedList(Of String, Integer)
        Dim RUNPARMS As New clsRUNPARMS(SecureID)

        Dim iColCnt As Integer = ColumnNames.Count

        For I = 0 To iColCnt - 1
            ColName = FormName + "|" + GridName + "|" + "Width|" + ColumnNames(I)
            Dim iCnt As Integer = RUNPARMS.cnt_PKI8(ColName, gCurrUserGuidID)
            If iCnt = 1 Then
                Dim WC$ = RUNPARMS.wc_PKI8(ColName, gCurrUserGuidID)
                Dim RS As SqlDataReader
                RS = RUNPARMS.SelectOne(SecureID, WC)
                If RS.HasRows Then
                    Do While RS.Read()
                        Dim Parm$ = RS.GetValue(0).ToString
                        Dim ParmValue$ = RS.GetValue(1).ToString
                        Dim UserID$ = RS.GetValue(0).ToString
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
            ColName$ = S.ToString
            Dim iKey As Integer = GridWidth.IndexOfKey(ColName)
            Dim ColWidth As Integer = GridWidth.Values(iKey)
            Dim A$(0)
            A = ColName.Split("|")
            Dim tColName$ = A(UBound(A))
            Try
                ColumnWidths.Add(ColWidth)
            Catch ex As Exception
                ColumnWidths.Add(100)
            End Try

        Next
        RUNPARMS = Nothing

        GC.Collect()
        GC.WaitForFullGCComplete()

    End Sub

    Sub removeGridColOrder(ByRef GridName As String, ByVal FormName As String, ByVal ColumnNames As List(Of String), ByVal ColumnWidths As List(Of Integer), ByRef ColumnDisplayOrder As List(Of Integer))
        Dim I As Integer = 0
        Dim ColName As String = ""

        Dim GridOrder As New SortedList(Of Integer, String)
        Dim RUNPARMS As New clsRUNPARMS(SecureID)

        Dim iColCnt As Integer = ColumnNames.Count

        For I = 0 To iColCnt - 1
            ColName = FormName + "|" + GridName + "|" + ColumnNames(I)
            Dim iCnt As Integer = RUNPARMS.cnt_PKI8(ColName, gCurrUserGuidID)
            If iCnt = 1 Then
                Dim WC$ = RUNPARMS.wc_PKI8(ColName, gCurrUserGuidID)
                RUNPARMS.Delete(WC)
            End If
        Next

        RUNPARMS = Nothing

        GC.Collect()
        GC.WaitForFullGCComplete()

        setDefaultGridColOrder(GridName, FormName, ColumnNames, ColumnDisplayOrder)

    End Sub
    Sub setDefaultGridColOrder(ByRef GridName As String, ByVal FormName As String, ByVal ColumnNames As List(Of String), ByRef ColumnDisplayOrder As List(Of Integer))
        Dim I As Integer = 0
        Dim ColName As String = ""

        Dim RUNPARMS As New clsRUNPARMS(SecureID)

        Try
            ColName = FormName + "|" + GridName + "|" + "$ColOrderActive"
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

        Dim iColCnt As Integer = ColumnNames.Count
        Dim iDisplayIndex As Integer = 0
        For I = 0 To iColCnt - 1
            '** Seen as problem, but needs more analysis
            ColumnDisplayOrder.Add(9)
        Next

        RUNPARMS = Nothing

        GC.Collect()
        GC.WaitForFullGCComplete()

    End Sub
End Class

