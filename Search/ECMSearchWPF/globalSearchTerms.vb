' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 07-16-2020
'
' Last Modified By : wdale
' Last Modified On : 07-16-2020
' ***********************************************************************
' <copyright file="globalSearchTerms.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
''' <summary>
''' Class globalSearchTerms.
''' </summary>
Module globalSearchTerms

    ''' <summary>
    ''' The page row limit
    ''' </summary>
    Public PageRowLimit As Integer = 75
    ''' <summary>
    ''' The page row increment
    ''' </summary>
    Public PageRowIncrement As Integer = 25

    ''' <summary>
    ''' The document lower page NBR
    ''' </summary>
    Public DocLowerPageNbr As Integer = 1
    ''' <summary>
    ''' The document upper page NBR
    ''' </summary>
    Public DocUpperPageNbr As Integer = PageRowLimit
    ''' <summary>
    ''' The email lower page NBR
    ''' </summary>
    Public EmailLowerPageNbr As Integer = 1
    ''' <summary>
    ''' The email upper page NBR
    ''' </summary>
    Public EmailUpperPageNbr As Integer = PageRowLimit

    ''' <summary>
    ''' The list of search terms
    ''' </summary>
    Public ListOfSearchTerms As New System.Collections.Generic.List(Of SVCSearch.DS_SearchTerms)
    ''' <summary>
    ''' The dictionary email search
    ''' </summary>
    Public dictEmailSearch As New Dictionary(Of String, String)
    ''' <summary>
    ''' The dictionary content search
    ''' </summary>
    Public dictContentSearch As New Dictionary(Of String, String)

    ''' <summary>
    ''' Adds the search term.
    ''' </summary>
    ''' <param name="SearchTypeCode">The search type code.</param>
    ''' <param name="Term">The term.</param>
    ''' <param name="TermVal">The term value.</param>
    ''' <param name="TermDatatype">The term datatype.</param>
    Public Sub AddSearchTerm(ByVal SearchTypeCode As String, ByVal Term As String, ByVal TermVal As String, ByVal TermDatatype As String)

        AddMasterSearchItem(Term, TermVal)

        Dim sItem As New SVCSearch.DS_SearchTerms
        sItem.SearchTypeCode = SearchTypeCode
        sItem.Term = Term
        sItem.TermVal = TermVal
        sItem.TermDatatype = TermDatatype

        ListOfSearchTerms.Add(sItem)

    End Sub

    ''' <summary>
    ''' Udpates the search term.
    ''' </summary>
    ''' <param name="SearchTypeCode">The search type code.</param>
    ''' <param name="Term">The term.</param>
    ''' <param name="TermVal">The term value.</param>
    ''' <param name="TermDatatype">The term datatype.</param>
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

    ''' <summary>
    ''' Zeroizes the search terms.
    ''' </summary>
    Public Sub ZeroizeSearchTerms()
        ListOfSearchTerms.Clear()
    End Sub

    ''' <summary>
    ''' Adds the master search item.
    ''' </summary>
    ''' <param name="sKey">The s key.</param>
    ''' <param name="sVal">The s value.</param>
    Sub AddMasterSearchItem(ByVal sKey As String, ByVal sVal As String)
        If dictMasterSearch.ContainsKey(sKey) Then
            dictMasterSearch.Item(sKey) = sVal
        Else
            dictMasterSearch.Add(sKey, sVal)
        End If
    End Sub


End Module
