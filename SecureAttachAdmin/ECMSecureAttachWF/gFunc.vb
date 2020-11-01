Public NotInheritable Class gFunc

    Public Shared gDict As Dictionary(Of String, String) = New Dictionary(Of String, String)

    Private Sub New()
    End Sub

    Public Shared Sub LoadDictVals(tkey As String, tval As String)

        If Not gDict.ContainsKey(tkey) Then
            gDict.Add(tkey, tval)
        End If

    End Sub

    Public Shared Sub setDefaultColOrder(ByRef dGrid As DataGridView)
        Dim i As Integer = dGrid.Columns.Count
        'myGridView.Columns["myFirstCol"].DisplayIndex = 0;
        dGrid.Columns("CompanyID").DisplayIndex = 0
        dGrid.Columns("RepoID").DisplayIndex = 1
        dGrid.Columns("Disabled").DisplayIndex = 2
        'dGrid.Columns("ExtensionData").DisplayIndex = i - 1
    End Sub

    Public Shared Sub PopulateGrid(ByRef dGrid As DataGridView, Cs As String, CompanyID As String, EncPW As String, LimitToCompany As Integer)

        Dim RC As Boolean = True
        Dim RetTxt As String = ""
        Try
            Dim dObj As New SVCGateway.DS_SecureAttach
            Dim DS As New List(Of SVCGateway.DS_SecureAttach)
            Dim DataOBJ As Object = gvar.gProxyGW.PopulateGrid(Cs, CompanyID, EncPW, RC, RetTxt, LimitToCompany)
            For Each dObj In DataOBJ
                DS.Add(dObj)
            Next
            dGrid.DataSource = DS
            setDefaultColOrder(dGrid)
        Catch ex As Exception
            MessageBox.Show("Error populating the Grid: " + ex.Message.ToString)
        End Try

    End Sub

    Public Shared Sub PopulateCombo(ByRef cbCompanyID As ComboBox, Cs As String, CompanyID As String, EncPW As String)

        Dim RC As Boolean = True
        Dim RetTxt As String = ""

        Try
            Dim S As String = gvar.gProxyGW.PopulateCombo(Cs, CompanyID, RC, RetTxt)
            If InStr(S, "|") > 0 Then
                Dim A() As String = S.Split("|")
                cbCompanyID.Items.Add("*ALL")
                For i As Integer = 0 To A.Count - 1
                    Dim sItem As String = A(i)
                    If sItem.Trim.Length > 0 Then
                        cbCompanyID.Items.Add(sItem)
                    End If
                Next
            End If
        Catch ex As Exception
            MessageBox.Show("Error populating the Grid: " + ex.Message.ToString)
        End Try

    End Sub

End Class
