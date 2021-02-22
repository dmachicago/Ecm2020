Module globalSearchTerms

    Public PageRowLimit As Integer = Convert.ToInt32(RowsToFetch)
    Public PageRowIncrement As Integer = Convert.ToInt32(RowsToFetch)

    Public DocLowerPageNbr As Integer = 1
    Public DocUpperPageNbr As Integer = Convert.ToInt32(RowsToFetch)
    Public EmailLowerPageNbr As Integer = 1
    Public EmailUpperPageNbr As Integer = Convert.ToInt32(RowsToFetch)

    Public ListOfSearchTerms As New System.Collections.Generic.List(Of SVCSearch.DS_SearchTerms)
    Public dictEmailSearch As New Dictionary(Of String, String)
    Public dictContentSearch As New Dictionary(Of String, String)

    Public Sub AddSearchTerm(ByVal SearchTypeCode As String, ByVal Term As String, ByVal TermVal As String, ByVal TermDatatype As String)

        AddMasterSearchItem(Term, TermVal)

        Dim sItem As New SVCSearch.DS_SearchTerms
        sItem.SearchTypeCode = SearchTypeCode
        sItem.Term = Term
        sItem.TermVal = TermVal
        sItem.TermDatatype = TermDatatype

        ListOfSearchTerms.Add(sItem)

    End Sub

    Public Sub UdpateSearchTerm(ByVal SearchTypeCode As String, ByVal Term As String, ByVal TermVal As String, ByVal TermDatatype As String)

        Dim bTermExists As Boolean = False
        Dim tKey As String = Term

        AddMasterSearchItem(Term, TermVal)
        For I As Integer = 0 To ListOfSearchTerms.Count - 1
            If ListOfSearchTerms.Item(I).Term.Equals(tKey) Then
                bTermExists = True
                ListOfSearchTerms.Item(I).TermVal = TermVal
            End If
        Next
        If Not bTermExists Then
            Dim sItem As New SVCSearch.DS_SearchTerms
            sItem.SearchTypeCode = SearchTypeCode
            sItem.Term = Term
            sItem.TermVal = TermVal
            sItem.TermDatatype = TermDatatype
            ListOfSearchTerms.Add(sItem)
        End If

    End Sub

    Public Sub ZeroizeSearchTerms()
        ListOfSearchTerms.Clear()
    End Sub

    Sub AddMasterSearchItem(ByVal sKey As String, ByVal sVal As String)
        If dictMasterSearch.ContainsKey(sKey) Then
            dictMasterSearch.Item(sKey) = sVal
        Else
            dictMasterSearch.Add(sKey, sVal)
        End If
    End Sub


End Module
