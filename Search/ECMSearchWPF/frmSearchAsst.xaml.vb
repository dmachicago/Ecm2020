' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 07-16-2020
'
' Last Modified By : wdale
' Last Modified On : 07-16-2020
' ***********************************************************************
' <copyright file="frmSearchAsst.xaml.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
Imports System.Text
Imports System.IO
Imports System.IO.IsolatedStorage
Imports System.Configuration

''' <summary>
''' Class frmSearchAsst.
''' Implements the <see cref="System.Windows.Window" />
''' Implements the <see cref="System.Windows.Markup.IComponentConnector" />
''' </summary>
''' <seealso cref="System.Windows.Window" />
''' <seealso cref="System.Windows.Markup.IComponentConnector" />
Public Class frmSearchAsst

    ''' <summary>
    ''' Gets or sets the generated search.
    ''' </summary>
    ''' <value>The generated search.</value>
    Public Property GeneratedSearch As String = ""
    ''' <summary>
    ''' The common
    ''' </summary>
    Dim COMMON As New clsCommonFunctions
    'Dim GVAR As App = App.Current
    ''' <summary>
    ''' The user identifier
    ''' </summary>
    Dim UserID As String = ""

    'Dim proxy As New SVCSearch.Service1Client
    'Dim EP As New clsEndPoint

    ''' <summary>
    ''' The iso
    ''' </summary>
    Dim ISO As New clsIsolatedStorage
    ''' <summary>
    ''' The temporary iso dir
    ''' </summary>
    Dim tempIsoDir As String = ISO.getTempDir
    ''' <summary>
    ''' The generated search text
    ''' </summary>
    Dim GeneratedSearchText As String = ""
    ''' <summary>
    ''' The thesaurus connection string
    ''' </summary>
    Dim ThesaurusConnectionString As String = ""

    ''' <summary>
    ''' The thesaurus words
    ''' </summary>
    Dim ThesaurusWords As New System.Collections.ObjectModel.ObservableCollection(Of String)
    ''' <summary>
    ''' The expanded words
    ''' </summary>
    Dim ExpandedWords As New System.Collections.ObjectModel.ObservableCollection(Of String)
    ''' <summary>
    ''' The object expanded words
    ''' </summary>
    Dim ObjExpandedWords As Object = Nothing
    ''' <summary>
    ''' The gen and view
    ''' </summary>
    Dim GenAndView As Boolean = False
    ''' <summary>
    ''' The search criteria
    ''' </summary>
    Public SearchCriteria As String = ""
    ''' <summary>
    ''' The g secure identifier
    ''' </summary>
    Dim gSecureID As String = -1
    ''' <summary>
    ''' The user unique identifier identifier
    ''' </summary>
    Dim UserGuidID As String = ""

    ''' <summary>
    ''' Initializes a new instance of the <see cref="frmSearchAsst"/> class.
    ''' </summary>
    ''' <param name="iSecureID">The i secure identifier.</param>
    Public Sub New(ByVal iSecureID As Integer)
        InitializeComponent()
        'EP.setSearchSvcEndPoint(proxy)

        Dim sVal As String = ""

        If dictMasterSearch IsNot Nothing Then
            For Each sKey In dictMasterSearch.Keys
                sVal = dictMasterSearch.Item(sKey)
                If sKey.Equals("CurrentGuid") Then
                    UserGuidID = dictMasterSearch.Item(sKey)
                ElseIf sKey.Equals("asst.txtAllOfTheseWords") Then
                    If sVal IsNot Nothing Then
                        txtAllOfTheseWords.Text = sVal
                    End If
                ElseIf sKey.Equals("asst.ckPhrase") Then
                    If sVal IsNot Nothing Then
                        If sVal.Equals("True") Then
                            ckPhrase.IsChecked = True
                        Else
                            ckPhrase.IsChecked = False
                        End If
                    End If
                ElseIf sKey.Equals("asst.ckNear") Then
                    If sVal IsNot Nothing Then
                        If sVal.Equals("True") Then
                            ckNear.IsChecked = True
                        Else
                            ckNear.IsChecked = False
                        End If
                    End If
                ElseIf sKey.Equals("asst.ckNone") Then
                    If sVal IsNot Nothing Then
                        If sVal.Equals("True") Then
                            ckNone.IsChecked = True
                        Else
                            ckNone.IsChecked = False
                        End If
                    End If
                ElseIf sKey.Equals("asst.ckInflection") Then
                    If sVal IsNot Nothing Then
                        If sVal.Equals("True") Then
                            ckInflection.IsChecked = True
                        Else
                            ckInflection.IsChecked = False
                        End If
                    End If
                ElseIf sKey.Equals("asst.ckClassonomy") Then
                    If sVal IsNot Nothing Then
                        If sVal.Equals("True") Then
                            ckClassonomy.IsChecked = True
                        Else
                            ckClassonomy.IsChecked = False
                        End If
                    End If
                ElseIf sKey.Equals("asst.txtExactPhrase") Then
                    If sVal IsNot Nothing Then
                        txtExactPhrase.Text = sVal
                    End If
                ElseIf sKey.Equals("asst.txtAnyOfThese") Then
                    If sVal IsNot Nothing Then
                        txtAnyOfThese.Text = sVal
                    End If
                ElseIf sKey.Equals("asst.txtNoneOfThese") Then
                    If sVal IsNot Nothing Then
                        txtNoneOfThese.Text = sVal
                    End If
                ElseIf sKey.Equals("asst.txtInflection") Then
                    If sVal IsNot Nothing Then
                        txtInflection.Text = sVal
                    End If
                ElseIf sKey.Equals("asst.txtMsThesuarus") Then
                    If sVal IsNot Nothing Then
                        txtMsThesuarus.Text = sVal
                    End If
                ElseIf sKey.Equals("asst.txtEcmThesaurus") Then
                    If sVal IsNot Nothing Then
                        txtEcmThesaurus.Text = sVal
                    End If
                ElseIf sKey.Equals("asst.cbAvailThesauri") Then
                    If sVal IsNot Nothing Then
                        cbAvailThesauri.Text = sVal
                    End If
                ElseIf sKey.Equals("asst.cbSelectedThesauri") Then
                    If sVal IsNot Nothing Then
                        cbSelectedThesauri.Text = sVal
                    End If
                ElseIf sKey.Equals("asst.cbDateRange") Then
                    If sVal IsNot Nothing Then
                        cbDateRange.Text = sVal
                    End If
                ElseIf sKey.Equals("asst.dtStart") Then
                    If sVal IsNot Nothing Then
                        dtStart.SelectedDate = CDate(sVal)
                    End If
                ElseIf sKey.Equals("asst.dtEnd") Then
                    If sVal IsNot Nothing Then
                        dtEnd.SelectedDate = CDate(sVal)
                    End If
                End If
            Next
        End If

        'AddHandler ProxySearch.getSynonymsCompleted, AddressOf client_getSynonyms
        'AddHandler ProxySearch.ExpandInflectionTermsCompleted, AddressOf client_ExpandInflectionTerms
        'AddHandler ProxySearch.getThesaurusIDCompleted, AddressOf client_getThesaurusID
        'EP.setSearchSvcEndPoint(proxy)

        UserID = _UserID
        gCurrUserGuidID = _UserGuid
        COMMON.SaveClick(3300, UserID)

        gSecureID = iSecureID
        cbDateRange.SelectedItem = "OFF"
    End Sub

    ''' <summary>
    ''' Handles the Click event of the OKButton control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub OKButton_Click(ByVal sender As Object, ByVal e As RoutedEventArgs) Handles OKButton.Click
        GenerateSearchCriteria()
        Me.DialogResult = True
    End Sub

    ''' <summary>
    ''' Handles the Click event of the CancelButton control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub CancelButton_Click(ByVal sender As Object, ByVal e As RoutedEventArgs) Handles CancelButton.Click
        Me.DialogResult = False
        GeneratedSearch = ""
        Me.Close()
    End Sub

    ''' <summary>
    ''' Generates the search criteria.
    ''' </summary>
    Sub GenerateSearchCriteria()

        If cbSelectedThesauri.Items.Count = 0 Then
            Dim name2 As String = cbAvailThesauri.Text
            If name2 IsNot Nothing Then
                cbSelectedThesauri.Items.Add(name2)
                cbSelectedThesauri.Items.Add(cbAvailThesauri.Text)
                cbSelectedThesauri.Text = cbAvailThesauri.Text
            End If
        End If


        ReformattedSearchString$ = ""
        Dim ArrayUseAllWords$() = Nothing
        Dim ArrayExactPhrases$() = Nothing
        Dim ArraySinglePhrase$() = Nothing
        Dim ArrayAnyOfTheseWords$() = Nothing
        Dim ArrayNoneOfTheseWords$() = Nothing
        Dim ArrayNearWords$() = Nothing

        Dim ArrayInflection$() = Nothing
        Dim ArrayMsThesaurus$() = Nothing
        Dim ArrayEcmThesaurus$() = Nothing


        Dim strUseAllWords$ = ""
        Dim strUseExactPhrase$ = ""
        Dim strUseAnyOfTheseWords$ = ""
        Dim strUseNoneOfTheseWords$ = ""
        Dim strUseNearWords$ = ""
        Dim strUseInflection$ = ""
        Dim strUseMsThesaurus$ = ""
        Dim strUseEcmThesaurus$ = ""

        Dim CH$ = ""

        txtInflection.Text = txtInflection.Text.Trim
        txtMsThesuarus.Text = txtMsThesuarus.Text.Trim

        RemoveDoubleQuotes(txtAllOfTheseWords.Text)
        RemoveDoubleQuotes(txtExactPhrase.Text)
        RemoveDoubleQuotes(txtAnyOfThese.Text)
        RemoveDoubleQuotes(txtNoneOfThese.Text)
        'RemoveDoubleQuotes(txtNear.Text)
        RemoveDoubleQuotes(txtInflection.Text)
        RemoveDoubleQuotes(txtMsThesuarus.Text)

        ArrayUseAllWords = Split(txtAllOfTheseWords.Text.Trim, " ")
        ArrayExactPhrases$ = Split(txtExactPhrase.Text.Trim, " ")
        ArrayAnyOfTheseWords = Split(Me.txtAnyOfThese.Text.Trim, " ")
        ArrayNoneOfTheseWords = Split(txtNoneOfThese.Text.Trim, " ")

        'ArrayNearWords = Split(txtNear.Text.Trim, " ")
        ArrayNearWords = SplitNearWords(txtNear.Text.Trim)

        ArrayInflection$ = Split(Me.txtInflection.Text.Trim, " ")
        ArrayMsThesaurus$ = Split(Me.txtMsThesuarus.Text.Trim, " ")
        ArrayEcmThesaurus$ = Split(Me.txtEcmThesaurus.Text.Trim, " ")

        RemoveKeyWords(ArrayUseAllWords, txtAllOfTheseWords.Text)
        RemoveKeyWords(ArrayExactPhrases$, txtExactPhrase.Text)
        RemoveKeyWords(ArrayAnyOfTheseWords, txtAnyOfThese.Text)
        RemoveKeyWords(ArrayNoneOfTheseWords, txtNoneOfThese.Text)
        RemoveKeyWords(ArrayNearWords, txtNear.Text)

        RemoveKeyWords(ArrayInflection$, txtInflection.Text)
        RemoveKeyWords(ArrayMsThesaurus$, txtMsThesuarus.Text)
        'RemoveKeyWords(ArrayEcmThesaurus$, txtEcmThesaurus.Text)


        Dim bAllOfTheseWords As Boolean = False
        Dim bExactPhrase As Boolean = False
        Dim bAnyOfThese As Boolean = False
        Dim bNoneOfThese As Boolean = False
        Dim bNear As Boolean = False
        Dim bInflection As Boolean = False
        Dim bMsThesaurus As Boolean = False
        Dim bEcmThesaurus As Boolean = False

        If txtAllOfTheseWords.Text.Trim.Length > 0 Then
            bAllOfTheseWords = True
        End If
        If txtExactPhrase.Text.Trim.Length > 0 Then
            bExactPhrase = True
        End If
        If txtAnyOfThese.Text.Trim.Length > 0 Then
            bAnyOfThese = True
        End If
        If txtNoneOfThese.Text.Trim.Length > 0 Then
            bNoneOfThese = True
        End If
        If txtNear.Text.Trim.Length > 0 Then
            bNear = True
        End If
        If txtInflection.Text.Trim.Length > 0 Then
            bInflection = True
        End If
        If txtMsThesuarus.Text.Trim.Length > 0 Then
            bMsThesaurus = True
        End If
        If txtEcmThesaurus.Text.Trim.Length > 0 Then
            bEcmThesaurus = True
        End If


        Dim I As Integer = 0

        If bAllOfTheseWords Then
            Dim TempStr$ = ""
            For I = 0 To UBound(ArrayUseAllWords)
                strUseAllWords$ = ""
                If ArrayUseAllWords(I).Trim.Length > 0 Then
                    TempStr$ = TempStr$ + " AND " + ChrW(34) + ArrayUseAllWords(I).ToString + ChrW(34) + " "
                End If
                strUseAllWords = TempStr$
            Next
            If strUseAllWords$.Equals("AND") Then
                strUseAllWords$ = ""
            End If
            strUseAllWords$ = strUseAllWords$.Trim
            If strUseAllWords$.Length > 0 Then
                'strUseAnyOfTheseWords$ = "(" + strUseAnyOfTheseWords$ + ")"
            End If
        End If

        If bExactPhrase Then
            If InStr(1, txtExactPhrase.Text.Trim, ",") > 0 Then
                strUseExactPhrase$ = ""
                ArraySinglePhrase$ = Split(txtExactPhrase.Text.Trim, ",")
                For ii As Integer = 0 To UBound(ArraySinglePhrase)
                    ArrayExactPhrases$ = Split(ArraySinglePhrase$(ii), " ")
                    Dim TempPhrase$ = ""
                    For I = 0 To UBound(ArrayExactPhrases)
                        TempPhrase$ = TempPhrase$ + ArrayExactPhrases$(I) + " "
                    Next
                    TempPhrase$ = TempPhrase$.Trim
                    If UBound(ArrayExactPhrases) > 0 Then
                        strUseExactPhrase$ = strUseExactPhrase$ + ChrW(34) + TempPhrase$ + ChrW(34) + " AND "
                        'strUseExactPhrase$ = "(" + ChrW(34) + strUseExactPhrase$ + ChrW(34) + ")"
                    End If
                Next
                If strUseExactPhrase$.Length > 1 Then
                    strUseExactPhrase$ = strUseExactPhrase$.Trim
                    strUseExactPhrase$ = Mid(strUseExactPhrase$, 1, strUseExactPhrase$.Length - 3)
                End If
            Else
                For I = 0 To UBound(ArrayExactPhrases)
                    If ArrayExactPhrases$(I).Trim.Length > 0 Then
                        strUseExactPhrase$ = strUseExactPhrase$ + ArrayExactPhrases$(I) + " "
                    End If
                Next
                If UBound(ArrayExactPhrases) > 0 Then
                    strUseExactPhrase$ = strUseExactPhrase$.Trim
                    strUseExactPhrase$ = ChrW(34) + strUseExactPhrase$ + ChrW(34)
                    'strUseExactPhrase$ = "(" + ChrW(34) + strUseExactPhrase$ + ChrW(34) + ")"
                End If
            End If
        End If

        If bAnyOfThese Then
            strUseAnyOfTheseWords$ = ""
            For I = 0 To UBound(ArrayAnyOfTheseWords)
                If ArrayAnyOfTheseWords(I).Trim.Length > 0 Then
                    strUseAnyOfTheseWords$ = strUseAnyOfTheseWords$ + " OR " + ChrW(34) + ArrayAnyOfTheseWords(I) + ChrW(34) + " "
                End If
            Next
            If strUseAnyOfTheseWords$.Equals("OR") Then
                strUseAnyOfTheseWords$ = ""
            End If
            strUseAnyOfTheseWords$ = strUseAnyOfTheseWords$.Trim
            If strUseAnyOfTheseWords$.Length > 0 Then
                'strUseAnyOfTheseWords$ = "(" + strUseAnyOfTheseWords$ + ")"
            End If
        End If

        If bNoneOfThese Then

            For I = 0 To UBound(ArrayNoneOfTheseWords)
                If ckNone.IsChecked = True Then
                    If ArrayNoneOfTheseWords(I).Trim.Length > 0 Then
                        strUseNoneOfTheseWords$ = strUseNoneOfTheseWords$ + " AND NOT " + ChrW(34) + ArrayNoneOfTheseWords(I) + ChrW(34) + " "
                    End If
                Else
                    If ArrayNoneOfTheseWords(I).Trim.Length > 0 Then
                        strUseNoneOfTheseWords$ = strUseNoneOfTheseWords$ + " OR NOT " + ChrW(34) + ArrayNoneOfTheseWords(I) + ChrW(34) + " "
                    End If
                End If
            Next

            strUseNoneOfTheseWords$ = strUseNoneOfTheseWords$.Trim
            If strUseNoneOfTheseWords$.Equals("-") Then
                strUseNoneOfTheseWords$ = ""
            End If
        End If

        If bNear Then

            For I = 0 To UBound(ArrayNearWords)
                If Not ArrayNearWords(I) = Nothing Then
                    If ArrayNearWords(I).Trim.Length > 0 Then
                        If UBound(ArrayNearWords) >= 1 Then
                            strUseNearWords$ = strUseNearWords$ + ArrayNearWords(I) + " NEAR "
                            'strUseNearWords$ = strUseNearWords$.Trim
                        End If
                    End If
                End If
            Next
            strUseNearWords$ = strUseNearWords$.Trim
            If strUseNearWords$.Equals("NEAR") Then
                strUseNearWords$ = ""
            End If
            If strUseNearWords.Trim.Trim.Length > 0 Then
                strUseNearWords = Mid(strUseNearWords, 1, strUseNearWords$.Length - 5)
                strUseNearWords = strUseNearWords.Trim
                'strUseNearWords = "(" + strUseNearWords + ")"
            End If

        End If

        If bInflection Then
            For I = 0 To UBound(ArrayInflection)
                If ckInflection.IsChecked Then
                    If ArrayInflection(I).Trim.Length > 0 Then
                        strUseInflection$ = strUseInflection$ + " And ^" + ArrayInflection(I) + " "
                    End If
                Else
                    If ArrayInflection(I).Trim.Length > 0 Then
                        strUseInflection$ = strUseInflection$ + " Or ^" + ArrayInflection(I) + " "
                    End If
                End If
            Next
        End If

        If bMsThesaurus Then
            For I = 0 To UBound(ArrayMsThesaurus)
                If ckClassonomy.IsChecked Then
                    If ArrayMsThesaurus(I).Trim.Length > 0 Then
                        strUseMsThesaurus = strUseMsThesaurus + " And ~" + ArrayMsThesaurus(I) + " "
                    End If
                Else
                    If ArrayMsThesaurus(I).Trim.Length > 0 Then
                        strUseMsThesaurus = strUseMsThesaurus + " Or ~" + ArrayMsThesaurus(I) + " "
                    End If
                End If
            Next
        End If

        If bEcmThesaurus Then
            'gThesaurusSearchText = txtEcmThesaurus.Text.Trim
            I = cbSelectedThesauri.Items.Count
            If I > 0 Then
                gThesauri.Clear()
                For k As Integer = 0 To cbSelectedThesauri.Items.Count - 1
                    Dim Tok$ = cbSelectedThesauri.Items(k).ToString
                    If Not gThesauri.Contains(Tok) Then
                        gThesauri.Add(Tok)
                    End If
                Next
            End If
        Else
            'gThesaurusSearchText = ""
            gThesauri.Clear()
            'If InStr(1, txtEcmThesaurus.Text.Trim, ",") > 0 Then
            '    strUseExactPhrase$ = ""
            '    ArraySinglePhrase$ = Split(txtEcmThesaurus.Text.Trim, ",")
            '    For ii As Integer = 0 To UBound(ArraySinglePhrase)
            '        ArrayExactPhrases$ = Split(ArraySinglePhrase$(ii), " ")
            '        Dim TempPhrase$ = ""
            '        For I = 0 To UBound(ArrayExactPhrases )
            '            TempPhrase$ = TempPhrase$ + ArrayExactPhrases$(I) + " "
            '        Next
            '        TempPhrase$ = TempPhrase$.Trim
            '        If UBound(ArrayExactPhrases ) > 0 Then
            '            strUseExactPhrase$ = strUseExactPhrase$ + ChrW(34) + TempPhrase$ + ChrW(34) + " AND #"
            '            'strUseExactPhrase$ = "(" + ChrW(34) + strUseExactPhrase$ + ChrW(34) + ")"
            '        End If
            '    Next
            '    If strUseExactPhrase$.Length > 1 Then
            '        strUseExactPhrase$ = strUseExactPhrase$.Trim
            '        strUseExactPhrase$ = Mid(strUseExactPhrase$, 1, strUseExactPhrase$.Length - 3)
            '    End If
            'Else
            '    For I = 0 To UBound(ArrayExactPhrases )
            '        If ArrayExactPhrases$(I).Trim.Length > 0 Then
            '            strUseExactPhrase$ = strUseExactPhrase$ + ArrayExactPhrases$(I) + " "
            '        End If
            '    Next
            '    If UBound(ArrayExactPhrases ) > 0 Then
            '        strUseExactPhrase$ = strUseExactPhrase$.Trim
            '        strUseExactPhrase$ = ChrW(34) + strUseExactPhrase$ + ChrW(34)
            '        'strUseExactPhrase$ = "(" + ChrW(34) + strUseExactPhrase$ + ChrW(34) + ")"
            '    End If
            'End If
        End If

        ReformattedSearchString$ = ""
        If bAllOfTheseWords Then
            ReformattedSearchString$ = ReformattedSearchString$ + strUseAllWords$
        End If

        If bExactPhrase And ckPhrase.IsChecked = True Then
            ReformattedSearchString$ = ReformattedSearchString$ + " AND " + strUseExactPhrase$
        End If
        If bExactPhrase And ckPhrase.IsChecked = False Then
            ReformattedSearchString$ = ReformattedSearchString$ + " OR " + strUseExactPhrase$
        End If

        If strUseAnyOfTheseWords$.Equals("OR") Then
            strUseAnyOfTheseWords$ = ""
        End If
        If bAnyOfThese Then
            ReformattedSearchString$ = ReformattedSearchString$ + " " + strUseAnyOfTheseWords$
        End If

        ValidateFirstWord(ReformattedSearchString)

        If bNoneOfThese = True Then
            If ReformattedSearchString$.Trim.Length > 0 Then
                ReformattedSearchString$ = "(" + ReformattedSearchString$ + ") "
            End If
        End If

        If bNoneOfThese And ckNone.IsChecked = True Then
            ReformattedSearchString$ = ReformattedSearchString$ + " " + strUseNoneOfTheseWords$
        End If
        If bNoneOfThese And ckNone.IsChecked = False Then
            ReformattedSearchString$ = ReformattedSearchString$ + " " + strUseNoneOfTheseWords$
        End If

        If bNear And ckNear.IsChecked = True Then
            If strUseNearWords$.Trim.Length > 0 Then
                ReformattedSearchString$ = ReformattedSearchString$ + " and " + "(" + strUseNearWords$ + ")"
            End If
        End If
        If bNear And ckNear.IsChecked = False Then
            If strUseNearWords$.Trim.Length > 0 Then
                ReformattedSearchString$ = ReformattedSearchString$ + " OR " + "(" + strUseNearWords$ + ")"
            End If
        End If

        If bMsThesaurus = True Then
            ReformattedSearchString$ = ReformattedSearchString$ + strUseMsThesaurus + " "
        End If
        If bInflection = True Then
            ReformattedSearchString$ = ReformattedSearchString$ + strUseInflection + " "
        End If

        ReformattedSearchString$ = ReformattedSearchString$.Trim
        If ReformattedSearchString$.Length = 0 Then
            ReformattedSearchString$ = " "
        End If
        CH = Mid(ReformattedSearchString$, ReformattedSearchString$.Length, 1)
        Dim builder As New StringBuilder(ReformattedSearchString)

        If CH = "-" Then
            builder.Insert(ReformattedSearchString$.Length, " ")
        End If
        If CH = "+" Then
            builder.Insert(ReformattedSearchString$.Length, " ")
        End If
        If CH = "|" Then
            builder.Insert(ReformattedSearchString$.Length, " ")
        End If

        CH = Mid(ReformattedSearchString$, 1, 1)
        If CH = "-" Then
            builder.Insert(1, " ")
        End If
        If CH = "+" Then
            builder.Insert(1, " ")
        End If
        If CH = "|" Then
            builder.Insert(1, " ")
        End If
        ReformattedSearchString$ = builder.ToString
        builder = Nothing

        ReformattedSearchString$ = ReformattedSearchString$.Trim

        If ReformattedSearchString$.Length > 3 Then
            ReformattedSearchString$ = ReformattedSearchString$.Trim
            If UCase(Mid(ReformattedSearchString$, 1, 4)) = "AND " Then
                ReformattedSearchString$ = Mid(ReformattedSearchString$, 4)
            End If
            If UCase(Mid(ReformattedSearchString$, 1, 3)) = "OR " Then
                ReformattedSearchString$ = Mid(ReformattedSearchString$, 3)
            End If
        End If

        SB.Text = ReformattedSearchString$

        Dim sDateKey$ = Me.cbDateRange.Text.Trim
        Dim eDate$ = ""
        Dim sDate$ = ""
        If dtStart.Text.Length > 0 Then
            sDate$ = CDate(dtStart.Text).ToString
        End If
        If dtEnd.Text.Length > 0 Then
            eDate$ = CDate(dtEnd.Text).ToString
        End If

        Select Case sDateKey
            Case "OFF"
                SB2.Visibility = Windows.Visibility.Collapsed
            Case "Between"
                SB2.Visibility = Windows.Visibility.Visible
                SB2.Text = "Content create date will be between " + sDate + " and " + eDate
            Case "Before"
                SB2.Visibility = Windows.Visibility.Collapsed
                SB2.Text = "Content create date will be before " + sDate
            Case "After"
                SB2.Visibility = Windows.Visibility.Visible
                SB2.Text = "Content create date will be after " + sDate
            Case "Not Between"
                SB2.Visibility = Windows.Visibility.Visible
                SB2.Text = "Content create date will NOT be between " + sDate + " and " + eDate
        End Select

        SaveCurrFields()

        GC.Collect()

        Try
            GeneratedSearchText = SB.Text
            If GenAndView Then
                MessageBox.Show(GeneratedSearchText)
            End If
        Catch ex As Exception
            Console.WriteLine(ex.Message)
        End Try

        GeneratedSearch = ReformattedSearchString

        Dim B As Boolean = False

    End Sub
    ''' <summary>
    ''' Clients the user parm insert update completed.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    Sub client_UserParmInsertUpdateCompleted(RC As Boolean)
        If RC Then
        Else
            MessageBox.Show("ERROR 100 client_ExpandInflectionTerms: Failed to update the associated DB Growth.")
        End If
    End Sub

    ''' <summary>
    ''' Handles the Click event of the btnExpInflection control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnExpInflection_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnExpInflection.Click
        'SELECT * FROM sys.dm_fts_parser ('FORMSOF(INFLECTIONAL,run) or FORMSOF(INFLECTIONAL,deep)', 1033, 0, 0)
        If txtInflection.Text.Trim.Length = 0 Then
            MessageBox.Show("Text must be present to expand - aborting expansion.")
            Return
        End If
        Dim sText As String = txtInflection.Text.Trim
        Dim CH$ = ""
        Dim tArray As New List(Of String)

        sText = sText.Replace(",", " ")
        sText = sText.Replace(ChrW(34), " ")

        Dim A$(0)
        Dim Words$ = ""
        A = sText.Split(" ")
        For i As Integer = 0 To UBound(A)
            If Not tArray.Contains(A(i).Trim) Then
                tArray.Add(A(i).Trim)
                Words = A(i).Trim
            End If
        Next
        Dim Qry$ = "Select display_term, source_term  as Expansion FROM sys.dm_fts_parser ('"

        For i As Integer = 0 To tArray.Count - 1
            Dim tWord$ = tArray(i).ToString
            Qry = Qry + vbCrLf + "    " + "FORMSOF(INFLECTIONAL," + tWord + ") or "
        Next
        Qry = Qry.Trim
        Qry = Mid(Qry, 1, Qry.Length - 3)
        Qry = Qry + "', 1033, 0, 0)" + vbCrLf
        Qry = Qry + " order by display_term, source_term " + vbCrLf



        ProxySearch.RecordGrowth(gSecureID, Qry)

    End Sub

    ''' <summary>
    ''' Clients the expand inflection terms.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    Sub client_ExpandInflectionTerms(RC As Boolean, RetMsg As String)
        If RC Then
            If RC Then
                MessageBox.Show(RetMsg)
            Else
                MessageBox.Show("ERROR client_ExpandInflectionTerms: Failed to process request for expansion.")
            End If
        Else
            MessageBox.Show("ERROR 100 client_ExpandInflectionTerms: Failed to update the associated DB Growth.")
        End If
        'RemoveHandler ProxySearch.ExpandInflectionTermsCompleted, AddressOf client_ExpandInflectionTerms
    End Sub

    ''' <summary>
    ''' Handles the Click event of the btnExpandThesaurus control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnExpandThesaurus_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnExpandThesaurus.Click
        'SELECT * FROM sys.dm_fts_parser ('FORMSOF(INFLECTIONAL,run) or FORMSOF(INFLECTIONAL,deep)', 1033, 0, 0)
        If txtMsThesuarus.Text.Trim.Length = 0 Then
            MessageBox.Show("Text must be present to expand - aborting expansion.")
            Return
        End If
        Dim sText As String = txtMsThesuarus.Text.Trim
        Dim CH$ = ""
        Dim tArray As New List(Of String)

        sText.Replace(",", " ")
        sText.Replace(ChrW(34), " ")

        Dim A$(0)
        Dim Words$ = ""
        A = sText.Split(" ")
        For i As Integer = 0 To UBound(A)
            If Not tArray.Contains(A(i).Trim) Then
                tArray.Add(A(i).Trim)
                Words = A(i).Trim
            End If
        Next

        Dim Qry$ = ""
        Dim DQ As String = ChrW(34)
        Qry$ = "Select display_term, source_term FROM sys.dm_fts_parser ('FORMSOF( THESAURUS, " + DQ + txtMsThesuarus.Text.Trim + DQ + ")', 2057, 0, 0) order by display_term"

        Qry$ = "Select display_term, source_term FROM sys.dm_fts_parser ('"

        'DMA.SayWords(Words )

        '** SELECT display_term, source_term FROM sys.dm_fts_parser ('
        '** FORMSOF(THESAURUS,"jump") or      
        '** FORMSOF(THESAURUS,"XL") or      
        '** FORMSOF(THESAURUS,"internet") or      
        '** FORMSOF(THESAURUS, "internet explorer") 
        '** ', 1033, 0, 0)  order by display_term, source_term  

        For i As Integer = 0 To tArray.Count - 1
            Dim tWord$ = tArray(i).ToString
            Qry = Qry + vbCrLf + "    " + "FORMSOF(THESAURUS," + DQ + tWord + DQ + ") or "
        Next
        Qry = Qry.Trim
        Qry = Mid(Qry, 1, Qry.Length - 3)
        Qry = Qry + "', 0, 0, 0)" + vbCrLf
        Qry = Qry + " order by display_term, source_term " + vbCrLf


        ProxySearch.RecordGrowth(gSecureID, Qry)

    End Sub

    ''' <summary>
    ''' Handles the Click event of the btnExpand control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnExpand_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnExpand.Click
        Dim Words$ = ""
        Dim tgtPhrases$ = txtEcmThesaurus.Text
        Dim ThesaurusName = ""
        Dim A$(0)

        If cbSelectedThesauri.Items.Count = 0 Then
            btnAddThesauri_Click(Nothing, Nothing)
            SB.Text = "No thesaurus was selected the default thesaurus is being used."
        Else
            SB.Text = ""
        End If
        Try
            ExpandedWords.Clear()
            ThesaurusWords.Clear()

            A = tgtPhrases.Split(" ")
            For i As Integer = 0 To UBound(A)
                If Not ThesaurusWords.Contains(A(i).Trim) Then
                    ThesaurusWords.Add(A(i).Trim)
                End If
            Next

            '** Get and use the default Thesaurus
            For I As Integer = 0 To cbSelectedThesauri.Items.Count - 1
                ThesaurusName = cbSelectedThesauri.Items(I).ToString
                getThesaurusID(ThesaurusName)
            Next

            Dim Msg As String = ""
            Dim Msg2 As String = ""


            ''DMA.SayWords(Words as string)

        Catch ex As Exception
            SB2.Text = ex.Message
        End Try
    End Sub
    ''' <summary>
    ''' Gets the thesaurus identifier.
    ''' </summary>
    ''' <param name="ThesaurusName">Name of the thesaurus.</param>
    Sub getThesaurusID(ByVal ThesaurusName As String)

        Dim SS As String = ProxySearch.getThesaurusID(gSecureID, ThesaurusName)
        client_getThesaurusID(SS)
    End Sub
    ''' <summary>
    ''' Clients the get thesaurus identifier.
    ''' </summary>
    ''' <param name="SS">The ss.</param>
    Sub client_getThesaurusID(SS As String)
        Dim TID As String = ""
        Dim B As Boolean = False
        If SS.Length > 0 Then
            TID = SS
            If TID.Length > 0 Then
                For Each token As String In ThesaurusWords
                    If Not ExpandedWords.Contains(token) Then
                        ExpandedWords.Add(token)
                        Dim BB As Boolean = True
                        For ii As Integer = 0 To lbWords.Items.Count - 1
                            If lbWords.Items(ii).Equals(token) Then
                                BB = False
                            End If
                        Next
                        If BB Then
                            lbWords.Items.Add(token)
                        End If
                    End If
                    ObjExpandedWords = ExpandedWords
                    Dim str As String = ProxySearch.getSynonyms(gSecureID, TID, token, ObjExpandedWords)
                    client_getSynonyms(str, ObjExpandedWords)
                Next
            End If
        Else
            MessageBox.Show("ERROR 100 client_ExpandInflectionTerms: Failed to update the associated DB Growth.")
        End If
        'RemoveHandler ProxySearch.getThesaurusIDCompleted, AddressOf client_getThesaurusID
    End Sub

    ''' <summary>
    ''' Clients the get synonyms.
    ''' </summary>
    ''' <param name="str">The string.</param>
    ''' <param name="ObjExpandedWords">The object expanded words.</param>
    Sub client_getSynonyms(str As String, ObjExpandedWords As String())

        If ObjExpandedWords.Count > 0 Then
            For i As Integer = 0 To ExpandedWords.Count - 1
                Dim Msg As String = ""
                Dim token As String = ExpandedWords(i).ToString

                Dim BB As Boolean = True
                For ii As Integer = 0 To lbWords.Items.Count - 1
                    If lbWords.Items(ii).Equals(token) Then
                        BB = False
                    End If
                Next
                If BB Then
                    lbWords.Items.Add(token)
                End If

                Msg += ExpandedWords(i).ToString + vbCrLf
                MessageBox.Show(Msg, "Expanded Words", MessageBoxButton.OK)
            Next
            MessageBox.Show("Expansion failed 100A", "Error in expansion", MessageBoxButton.OK)
        Else

        End If
    End Sub
    ''' <summary>
    ''' Validates the first word.
    ''' </summary>
    ''' <param name="ReformattedSearchString">The reformatted search string.</param>
    Sub ValidateFirstWord(ByRef ReformattedSearchString As String)
        Dim S As String = ReformattedSearchString$.Trim

        Dim I As Integer = InStr(1, S, " ")
        If I > 0 Then
            Dim tWord$ = Mid(S, 1, I)
            tWord = tWord.Trim
            Dim B As Boolean = isKeyWord(tWord)
            If B = True Then
                S = Mid(S, I)
                S = S.Trim
            End If
        End If

        ReformattedSearchString$ = S

    End Sub
    ''' <summary>
    ''' Determines whether [is key word] [the specified kw].
    ''' </summary>
    ''' <param name="KW">The kw.</param>
    ''' <returns><c>true</c> if [is key word] [the specified kw]; otherwise, <c>false</c>.</returns>
    Function isKeyWord(ByVal KW As String) As Boolean
        Dim B As Boolean = False
        KW = UCase(KW)
        Select Case KW
            Case "AND"
                Return True
            Case "OR"
                Return True
            Case "NOT"
                Return True
            Case "NEAR"
                Return True
        End Select
        Return B
    End Function

    ''' <summary>
    ''' Handles the Click event of the btnAddThesauri control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnAddThesauri_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnAddThesauri.Click
        Dim I As Integer = 0
        For I = 0 To cbSelectedThesauri.Items.Count - 1
            Dim name1$ = cbSelectedThesauri.Items(I).ToString
            Dim name2 = cbAvailThesauri.Text
            If UCase(name1) = UCase(name2) Then
                Return
            End If
        Next
        cbSelectedThesauri.Items.Add(cbAvailThesauri.Text)
        cbSelectedThesauri.Text = cbAvailThesauri.Text
    End Sub

    ''' <summary>
    ''' Saves the curr fields.
    ''' </summary>
    Sub SaveCurrFields()

        ISO.ZeroizeTempFile("AssistParms.dat")

        Dim AllOfTheseWords As String = txtAllOfTheseWords.Text.Trim
        Dim ExactPhrase As String = txtExactPhrase.Text.Trim
        Dim AnyOfThese As String = txtAnyOfThese.Text.Trim
        Dim NoneOfThese As String = txtNoneOfThese.Text.Trim
        Dim Near As String = txtNear.Text.Trim
        Dim Inflection As String = txtInflection.Text.Trim
        Dim Thesuarus As String = txtMsThesuarus.Text.Trim
        Dim StartDt As String = dtStart.Text.ToString
        Dim EndDt As String = dtEnd.Text.ToString
        Dim DateRange As String = cbDateRange.Text
        Dim sCheckBox1 As String = ckPhrase.IsChecked.ToString
        Dim sCheckBox3 As String = ckNone.IsChecked.ToString
        Dim sCheckBox4 As String = ckNear.IsChecked.ToString
        Dim sckAndInflection As String = ckInflection.IsChecked.ToString
        Dim sckAndThesaurus As String = ckClassonomy.IsChecked.ToString
        Dim EcmThesaurus As String = txtEcmThesaurus.Text.Trim

        Dim S As String = AllOfTheseWords
        S = S + ChrW(254) + ExactPhrase
        S = S + ChrW(254) + AnyOfThese
        S = S + ChrW(254) + NoneOfThese
        S = S + ChrW(254) + Near
        S = S + ChrW(254) + Inflection
        S = S + ChrW(254) + Thesuarus
        S = S + ChrW(254) + StartDt
        S = S + ChrW(254) + EndDt
        S = S + ChrW(254) + DateRange
        S = S + ChrW(254) + sCheckBox1
        S = S + ChrW(254) + sCheckBox3
        S = S + ChrW(254) + sCheckBox4
        S = S + ChrW(254) + sckAndInflection
        S = S + ChrW(254) + sckAndThesaurus
        S = S + ChrW(254) + EcmThesaurus

        WriteToAssistFile(S)

    End Sub
    ''' <summary>
    ''' Populates the curr fields.
    ''' </summary>
    ''' <param name="msg">The MSG.</param>
    Sub PopulateCurrFields(ByVal msg As String)
        Dim A$(0)
        A = msg.Split(ChrW(254))
        If UBound(A) < 2 Then
            Return
        End If
        Dim S As String = ""

        txtAllOfTheseWords.Text = A(0)
        txtExactPhrase.Text = A(1)
        txtAnyOfThese.Text = A(2)
        txtNoneOfThese.Text = A(3)
        txtNear.Text = A(4)
        txtInflection.Text = A(5)
        txtMsThesuarus.Text = A(6)
        dtStart.Text = A(7)
        dtEnd.Text = A(8)
        cbDateRange.Text = A(9)

        S = A(10)
        If UCase(S).Equals("TRUE") Then
            ckPhrase.IsChecked = True
        Else
            ckPhrase.IsChecked = False
        End If

        S = A(11)
        If UCase(S).Equals("TRUE") Then
            ckNone.IsChecked = True
        Else
            ckNone.IsChecked = False
        End If

        S = A(12)
        If UCase(S).Equals("TRUE") Then
            ckNear.IsChecked = True
        Else
            ckNear.IsChecked = False
        End If

        S = A(13)
        If UCase(S).Equals("TRUE") Then
            ckInflection.IsChecked = True
        Else
            ckInflection.IsChecked = False
        End If

        S = A(14)
        If UCase(S).Equals("TRUE") Then
            ckClassonomy.IsChecked = True
        Else
            ckClassonomy.IsChecked = False
        End If

        S = A(15)
        txtEcmThesaurus.Text = S

    End Sub
    ''' <summary>
    ''' Writes to assist file.
    ''' </summary>
    ''' <param name="Msg">The MSG.</param>
    Public Sub WriteToAssistFile(ByVal Msg As String)
        Try
            Dim cPath As String = tempIsoDir
            Dim tFQN$ = cPath + "\AssistParms.dat"
            ISO.AppendTempFile("AssistParms.dat", Msg)
            Using sw As StreamWriter = New StreamWriter(tFQN, False)
                sw.WriteLine(Msg)
                sw.Close()
            End Using
        Catch ex As Exception
            Console.WriteLine("frmSearchAssist : WriteToAssistFile : 688 : " + ex.Message)
        End Try
    End Sub
    ''' <summary>
    ''' xes the read assist file.
    ''' </summary>
    ''' <param name="Msg">The MSG.</param>
    Public Sub xReadAssistFile(ByRef Msg As String)
        Try
            Dim cPath As String = tempIsoDir
            Dim tFQN$ = cPath + "\AssistParms.dat"
            Using sr As StreamReader = New StreamReader(tFQN)
                Msg = sr.ReadLine()
                sr.Close()
            End Using
        Catch ex As Exception
            Console.WriteLine("frmSearchAssist : WriteToAssistFile : 688 : " + ex.Message)
        End Try
    End Sub
    ''' <summary>
    ''' Removes the double quotes.
    ''' </summary>
    ''' <param name="TgtStr">The TGT string.</param>
    Sub RemoveDoubleQuotes(ByVal TgtStr As String)
        TgtStr = TgtStr.Replace(ChrW(34), " ")
    End Sub
    ''' <summary>
    ''' Removes the key words.
    ''' </summary>
    ''' <param name="aList">a list.</param>
    ''' <param name="CorrectedText">The corrected text.</param>
    Sub RemoveKeyWords(ByVal aList() As String, ByRef CorrectedText As String)
        CorrectedText = ""
        Dim I As Integer = 0
        For I = 0 To aList.Count - 1
            If aList(I) = Nothing Then
                'Console.WriteLine("XXXX")
            Else
                Dim W As String = aList(I).Trim
                W = UCase(W)
                Select Case W
                    Case "NEAR"
                        aList(I) = ""
                    Case "AND"
                        aList(I) = ""
                    Case "OR"
                        aList(I) = ""
                    Case "NOT"
                        aList(I) = ""
                End Select
                CorrectedText = CorrectedText + " " + aList(I)
            End If

        Next
    End Sub
    ''' <summary>
    ''' Splits the near words.
    ''' </summary>
    ''' <param name="S">The s.</param>
    ''' <returns>Array.</returns>
    Private Function SplitNearWords(ByVal S As String) As Array

        Dim A As New List(Of String)
        Dim AR$(0)

        S = S.Trim
        Dim Token As String = ""
        Dim I As Integer = 0
        Dim Dels$ = " "
        Dim CH$ = ""

        For I = 1 To S.Length
            CH = Mid(S, I, 1)
            If CH.Equals(" ") Then
                If Token.Length > 0 Then
                    A.Add(Token)
                    Token = ""
                End If
            ElseIf CH.Equals(ChrW(34)) Then
                Dim K As Integer = InStr(I + 1, S, ChrW(34))
                Dim Phrase$ = Mid(S, I, K - I + 1)
                If Token.Length > 0 Then
                    A.Add(Token)
                    I = K
                End If
                If Phrase$.Length > 0 Then
                    A.Add(Phrase)
                    I = K
                End If
                I = K
                Token = ""
                Phrase$ = ""
            Else
                Token = Token + CH
            End If
        Next
        If Token.Length > 0 Then
            A.Add(Token)
        End If
        ReDim AR(A.Count)
        For I = 0 To A.Count - 1
            Console.WriteLine(A(I).ToString)
            AR(I) = A(I).ToString
        Next

        Return AR

    End Function

    ''' <summary>
    ''' Sets the calendar widgets.
    ''' </summary>
    Sub SetCalendarWidgets()
        If cbDateRange.Text.ToUpper.Equals("OFF") Then
            dtStart.Visibility = Windows.Visibility.Collapsed
            dtEnd.Visibility = Windows.Visibility.Collapsed
            dtStart.SelectedDate = Nothing
            dtEnd.SelectedDate = Nothing
        End If
        If cbDateRange.Text.Equals("Between") Then
            dtStart.Visibility = Windows.Visibility.Visible
            dtEnd.Visibility = Windows.Visibility.Visible
            dtStart.SelectedDate = Nothing
            dtEnd.SelectedDate = Nothing
        End If
        If cbDateRange.Text.Equals("Not Between") Then
            dtStart.Visibility = Windows.Visibility.Visible
            dtEnd.Visibility = Windows.Visibility.Visible
            dtStart.SelectedDate = Nothing
            dtEnd.SelectedDate = Nothing
        End If
        If cbDateRange.Text.Equals("After/On") Then
            dtStart.Visibility = Windows.Visibility.Collapsed
            dtEnd.Visibility = Windows.Visibility.Visible
            dtStart.SelectedDate = Nothing
            dtEnd.SelectedDate = Nothing
        End If
        If cbDateRange.Text.Equals("Before/On") Then
            dtStart.Visibility = Windows.Visibility.Visible
            dtEnd.Visibility = Windows.Visibility.Collapsed
            dtStart.SelectedDate = Nothing
            dtEnd.SelectedDate = Nothing
        End If
    End Sub

    ''' <summary>
    ''' Handles the Click event of the btnGen control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnGen_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnGen.Click
        GenAndView = True
        GenerateSearchCriteria()
        GenAndView = False
    End Sub

    ''' <summary>
    ''' Handles the Click event of the Button2 control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs)

    End Sub

    ''' <summary>
    ''' Handles the Click event of the btnRemoveThesauri control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnRemoveThesauri_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnRemoveThesauri.Click
        Dim I As Integer = 0
        Dim name1$ = cbSelectedThesauri.Items(I).ToString
        For I = 0 To cbSelectedThesauri.Items.Count - 1
            Dim name2 = cbSelectedThesauri.Text
            If UCase(name1) = UCase(name2) Then
                cbSelectedThesauri.Items.RemoveAt(I)
                Exit For
            End If
        Next
    End Sub

    ''' <summary>
    ''' Allows an object to try to free resources and perform other cleanup operations before it is reclaimed by garbage collection.
    ''' </summary>
    Protected Overrides Sub Finalize()
        Try

        Finally
            MyBase.Finalize()      'define the destructor

            'RemoveHandler ProxySearch.getSynonymsCompleted, AddressOf client_getSynonyms
            'RemoveHandler ProxySearch.ExpandInflectionTermsCompleted, AddressOf client_ExpandInflectionTerms
            'RemoveHandler ProxySearch.getThesaurusIDCompleted, AddressOf client_getThesaurusID

            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try
    End Sub

    ''' <summary>
    ''' Handles the Unloaded event of the ChildWindow control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ChildWindow_Unloaded(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles MyBase.Unloaded
        'Application.Current.RootVisual.SetValue(Control.IsEnabledProperty, True)
    End Sub

    ''' <summary>
    ''' Adds the dictionary items.
    ''' </summary>
    Sub AddDictItems()

        UpdateSearchDict("asst.txtAllOfTheseWords", txtAllOfTheseWords.Text.Trim)
        UpdateSearchDict("asst.ckPhrase", ckPhrase.ToString)
        UpdateSearchDict("asst.ckNear", ckNear.ToString)
        UpdateSearchDict("asst.ckNone", ckNone.ToString)
        UpdateSearchDict("asst.ckInflection", ckPhrase.ToString)
        UpdateSearchDict("asst.ckClassonomy", ckPhrase.ToString)
        UpdateSearchDict("asst.txtExactPhrase", txtExactPhrase.Text.Trim)
        UpdateSearchDict("asst.txtAnyOfThese", txtAnyOfThese.Text.Trim)
        UpdateSearchDict("asst.txtNear", txtNear.Text.Trim)
        UpdateSearchDict("asst.txtNoneOfThese", txtNoneOfThese.Text.Trim)
        UpdateSearchDict("asst.txtInflection", txtInflection.Text.Trim)
        UpdateSearchDict("asst.txtMsThesuarus", txtMsThesuarus.Text.Trim)
        UpdateSearchDict("asst.txtEcmThesaurus", txtEcmThesaurus.Text.Trim)
        UpdateSearchDict("asst.cbAvailThesauri", cbAvailThesauri.Text.Trim)
        UpdateSearchDict("asst.cbSelectedThesauri", cbSelectedThesauri.Text.Trim)

        UpdateSearchDict("asst.cbDateRange", cbDateRange.Text.Trim)
        UpdateSearchDict("asst.dtStart", dtStart.SelectedDate.ToString)
        UpdateSearchDict("asst.dtEnd", dtEnd.SelectedDate.ToString)

    End Sub

    ''' <summary>
    ''' Updates the search dictionary.
    ''' </summary>
    ''' <param name="tKey">The t key.</param>
    ''' <param name="tValue">The t value.</param>
    Sub UpdateSearchDict(ByVal tKey As String, ByVal tValue As String)
        'If Not formLoaded Then
        '    Return
        'End If

        If InStr(tKey, "content.", CompareMethod.Text) = 0 Then
            tKey = "content." + tKey
        End If

        If dictMasterSearch.ContainsKey(tKey) Then
            dictMasterSearch.Item(tKey) = tValue
            SB.Text = tKey + " updated"
        Else
            dictMasterSearch.Add(tKey, tValue)
            SB.Text = tKey + " added"
        End If
    End Sub

    ''' <summary>
    ''' Handles the TextChanged event of the txtAllOfTheseWords control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.TextChangedEventArgs"/> instance containing the event data.</param>
    Private Sub txtAllOfTheseWords_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles txtAllOfTheseWords.TextChanged
        'GenerateSearchCriteria()
    End Sub

    ''' <summary>
    ''' Handles the TextChanged event of the txtExactPhrase control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.TextChangedEventArgs"/> instance containing the event data.</param>
    Private Sub txtExactPhrase_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles txtExactPhrase.TextChanged
        'GenerateSearchCriteria()
    End Sub

    ''' <summary>
    ''' Handles the TextChanged event of the txtAnyOfThese control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.TextChangedEventArgs"/> instance containing the event data.</param>
    Private Sub txtAnyOfThese_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles txtAnyOfThese.TextChanged
        'GenerateSearchCriteria()
    End Sub

    ''' <summary>
    ''' Handles the TextChanged event of the txtNear control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.TextChangedEventArgs"/> instance containing the event data.</param>
    Private Sub txtNear_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles txtNear.TextChanged
        'GenerateSearchCriteria()
    End Sub

    ''' <summary>
    ''' Handles the TextChanged event of the txtNoneOfThese control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.TextChangedEventArgs"/> instance containing the event data.</param>
    Private Sub txtNoneOfThese_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles txtNoneOfThese.TextChanged
        'GenerateSearchCriteria()
    End Sub

    ''' <summary>
    ''' Handles the TextChanged event of the txtInflection control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.TextChangedEventArgs"/> instance containing the event data.</param>
    Private Sub txtInflection_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles txtInflection.TextChanged
        'GenerateSearchCriteria()
    End Sub

    ''' <summary>
    ''' Handles the TextChanged event of the txtMsThesuarus control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.TextChangedEventArgs"/> instance containing the event data.</param>
    Private Sub txtMsThesuarus_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles txtMsThesuarus.TextChanged
        'GenerateSearchCriteria()
    End Sub

    ''' <summary>
    ''' Handles the TextChanged event of the txtEcmThesaurus control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.TextChangedEventArgs"/> instance containing the event data.</param>
    Private Sub txtEcmThesaurus_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles txtEcmThesaurus.TextChanged
        'GenerateSearchCriteria()
    End Sub

    ''' <summary>
    ''' Handles the Checked event of the ckPhrase control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckPhrase_Checked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckPhrase.Checked
        'GenerateSearchCriteria()
    End Sub

    ''' <summary>
    ''' Handles the Unchecked event of the ckPhrase control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckPhrase_Unchecked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckPhrase.Unchecked
        'GenerateSearchCriteria()
    End Sub

    ''' <summary>
    ''' Handles the Checked event of the ckNear control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckNear_Checked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckNear.Checked
        'GenerateSearchCriteria()
    End Sub

    ''' <summary>
    ''' Handles the Unchecked event of the ckNear control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckNear_Unchecked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckNear.Unchecked
        'GenerateSearchCriteria()
    End Sub

    ''' <summary>
    ''' Handles the Checked event of the ckNone control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckNone_Checked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckNone.Checked
        'GenerateSearchCriteria()
    End Sub

    ''' <summary>
    ''' Handles the Unloaded event of the ckNone control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckNone_Unloaded(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckNone.Unloaded
        'GenerateSearchCriteria()
    End Sub

    ''' <summary>
    ''' Handles the Checked event of the ckInflection control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckInflection_Checked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckInflection.Checked
        'GenerateSearchCriteria()
    End Sub

    ''' <summary>
    ''' Handles the Unchecked event of the ckInflection control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckInflection_Unchecked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckInflection.Unchecked
        'GenerateSearchCriteria()
    End Sub

    ''' <summary>
    ''' Handles the Checked event of the ckClassonomy control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckClassonomy_Checked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckClassonomy.Checked
        'GenerateSearchCriteria()
    End Sub

    ''' <summary>
    ''' Handles the Unchecked event of the ckClassonomy control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckClassonomy_Unchecked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckClassonomy.Unchecked
        'GenerateSearchCriteria()
    End Sub

    ''' <summary>
    ''' Handles the SelectionChanged event of the cbDateRange control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="SelectionChangedEventArgs"/> instance containing the event data.</param>
    Private Sub cbDateRange_SelectionChanged(sender As Object, e As SelectionChangedEventArgs) Handles cbDateRange.SelectionChanged
        SetCalendarWidgets()
    End Sub
End Class
