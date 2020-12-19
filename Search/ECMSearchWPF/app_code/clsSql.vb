' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 12-15-2020
'
' Last Modified By : wdale
' Last Modified On : 12-15-2020
' ***********************************************************************
' <copyright file="clsSql.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
Imports System.Configuration
Imports System
'Imports System.Data.SqlClient
Imports System.Collections
Imports System.Collections.Specialized
Imports System.Collections.ObjectModel
Imports System.IO
Imports System.Threading
Imports ECMEncryption

''' <summary>
''' Class clsSql.
''' </summary>
Public Class clsSql
    'Dim DB As New clsDatabase



    ''' <summary>
    ''' The proxy2
    ''' </summary>
    Dim proxy2 As New SVCSearch.Service1Client
    ''' <summary>
    ''' The proxy3
    ''' </summary>
    Dim proxy3 As New SVCSearch.Service1Client

    ''' <summary>
    ''' The dma
    ''' </summary>
    Dim DMA As New clsDma
    ''' <summary>
    ''' The gen
    ''' </summary>
    Dim GEN As New clsGenerator
    ''' <summary>
    ''' The en c2
    ''' </summary>
    Dim ENC2 As New ECMEncrypt()
    ''' <summary>
    ''' The utility
    ''' </summary>
    Dim UTIL As New clsUtility
    ''' <summary>
    ''' The log
    ''' </summary>
    Dim LOG As New clsLogMain

    ''' <summary>
    ''' The expanded words
    ''' </summary>
    Dim ExpandedWords As New List(Of String)
    ''' <summary>
    ''' The list of phrases
    ''' </summary>
    Dim ListOfPhrases As String = ""
    ''' <summary>
    ''' The b running SQL
    ''' </summary>
    Dim bRunningSql As Boolean = False
    ''' <summary>
    ''' The getting thesaurus words
    ''' </summary>
    Dim gettingThesaurusWords As Boolean = False
    ''' <summary>
    ''' The b save to clip board
    ''' </summary>
    Dim bSaveToClipBoard As Boolean = True

    ''' <summary>
    ''' The text search
    ''' </summary>
    Dim txtSearch$ = Nothing
    ''' <summary>
    ''' The get count only
    ''' </summary>
    Dim getCountOnly As Boolean = Nothing
    ''' <summary>
    ''' The use existing records only
    ''' </summary>
    Dim UseExistingRecordsOnly As Boolean = Nothing
    ''' <summary>
    ''' The ck weighted
    ''' </summary>
    Dim ckWeighted As Boolean = Nothing
    ''' <summary>
    ''' The generated SQL
    ''' </summary>
    Dim GeneratedSQL As String = Nothing
    ''' <summary>
    ''' The is admin
    ''' </summary>
    Dim isAdmin As Boolean = Nothing
    ''' <summary>
    ''' The ck business
    ''' </summary>
    Dim ckBusiness As Boolean = Nothing
    ''' <summary>
    ''' The is inflectional term
    ''' </summary>
    Dim isInflectionalTerm As Boolean = False
    ''' <summary>
    ''' The inflectional token
    ''' </summary>
    Dim InflectionalToken As Boolean = False
    ''' <summary>
    ''' The thesaurus list
    ''' </summary>
    Dim ThesaurusList As New List(Of String)
    ''' <summary>
    ''' The thesaurus words
    ''' </summary>
    Dim ThesaurusWords As New List(Of String)

    ''' <summary>
    ''' The g secure identifier
    ''' </summary>
    Dim gSecureID As String = -1
    ''' <summary>
    ''' Initializes a new instance of the <see cref="clsSql"/> class.
    ''' </summary>
    Sub New()

        gSecureID = _SecureID

        'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
        'AddHandler proxy2.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
        'AddHandler proxy3.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
        'AddHandler ProxySearch.getSynonymsCompleted, AddressOf client_getSynonyms

        'EP.setSearchSvcEndPoint(proxy)

    End Sub

    ''' <summary>
    ''' Gets or sets the p inflectional token.
    ''' </summary>
    ''' <value>The p inflectional token.</value>
    Property pInflectionalToken() As String
        Get
            Return InflectionalToken
        End Get
        Set(ByVal tVal As String)
            InflectionalToken = tVal
        End Set
    End Property
    ''' <summary>
    ''' Gets or sets a value indicating whether [b inflectional term].
    ''' </summary>
    ''' <value><c>true</c> if [b inflectional term]; otherwise, <c>false</c>.</value>
    Property bInflectionalTerm() As Boolean
        Get
            Return isInflectionalTerm
        End Get
        Set(ByVal tVal As Boolean)
            isInflectionalTerm = tVal
        End Set
    End Property

    ''' <summary>
    ''' Gens the document search SQL.
    ''' </summary>
    ''' <param name="SearchString">The search string.</param>
    ''' <param name="ckLimitToExisting">if set to <c>true</c> [ck limit to existing].</param>
    ''' <param name="txtThesaurus">The text thesaurus.</param>
    ''' <param name="cbThesaurusText">The cb thesaurus text.</param>
    ''' <param name="ckLimitToLib">if set to <c>true</c> [ck limit to library].</param>
    ''' <param name="LibraryName">Name of the library.</param>
    ''' <returns>System.String.</returns>
    Function GenDocSearchSql(ByVal SearchString As String, ByVal ckLimitToExisting As Boolean, ByVal txtThesaurus As String, ByVal cbThesaurusText As String, ByVal ckLimitToLib As Boolean, ByVal LibraryName As String) As String
        Dim WhereClause$ = ""
        Dim bCopyToClipboard As Boolean = True
        Dim UserSql$ = ""

        If SearchString$ = Nothing Then
            LOG.WriteToSqlLog("All required variables not set to call this function.")
            'return ""
        End If
        If getCountOnly = Nothing Then
            getCountOnly = False
            'LOG.WriteToSqlLog("All required variables not set to call this function.")
            'return ""
        End If
        If ckWeighted = Nothing Then
            ckWeighted = True
            LOG.WriteToSqlLog("ckWeighted 201: All required variables not set to call this function.")
            'return ""
        End If


        GeneratedSQL$ = ""
        '**WDM Removed 7/12/2009 GeneratedSQL$ = genHeader()
        GeneratedSQL$ += vbCrLf


        If getCountOnly Then
            GeneratedSQL$ += genContenCountSql()
        Else

            GeneratedSQL$ += getContentTblCols(ckWeighted)
            If ckWeighted Then
                GeneratedSQL$ += genIsAbout(ckWeighted, ckBusiness, SearchString, False)
            End If

            GeneratedSQL$ += " WHERE " + vbCrLf

            'genDocWhereClause(WhereClause as string)
            Dim ContainsClause$ = ""
            '************************************************************************************************************************************************************
            ContainsClause$ = genContainsClause(SearchString, ckBusiness, ckWeighted, False, ckLimitToExisting, ThesaurusList, txtThesaurus, cbThesaurusText, "DOC")
            '************************************************************************************************************************************************************

            ContainsClause$ = ContainsClause$ + genUseExistingRecordsOnly(UseExistingRecordsOnly, "SourceGuid")

            '***********************************************************************
            'isAdmin = gisadmin
            If gIsAdmin = False Then
                gIsAdmin = gIsGlobalSearcher
            End If
            UserSql = genAdminContentSql(isAdmin, ckLimitToLib, LibraryName)
            '***********************************************************************
            If ContainsClause.Length Then
                GeneratedSQL$ = GeneratedSQL$ + vbCrLf + ContainsClause
            End If

            If bCopyToClipboard Then
                Dim tClip$ = "/* Part2 */ " + vbCrLf
                tClip += GeneratedSQL$
            End If


            If UserSql$.Length > 0 Then
                GeneratedSQL$ += vbCrLf + UserSql
            End If
        End If


        If getCountOnly Then
        Else
            If ckWeighted = True Then
                GeneratedSQL$ = GeneratedSQL$ + " and KEY_TBL.RANK >= " + MinRating.ToString + vbCrLf
            Else
            End If


            If ckWeighted Then
                'GeneratedSQL$ += vbCrLf + " or isPublic = 'Y' "
                GeneratedSQL$ += vbCrLf + " ORDER BY KEY_TBL.RANK DESC "
            Else
                'GeneratedSQL$ += vbCrLf + " or isPublic = 'Y' "
                GeneratedSQL$ += vbCrLf + " order by [SourceName] "
            End If
        End If


        If bCopyToClipboard Then
            Dim tClip$ = "/* Final */ " + vbCrLf
            tClip += GeneratedSQL$
        End If


        ValidateNotClauses(GeneratedSQL)

        DMA.ckFreetextRemoveOr(GeneratedSQL, " FREETEXT (")
        Return GeneratedSQL


    End Function


    ''' <summary>
    ''' Gets or sets the p generated SQL.
    ''' </summary>
    ''' <value>The p generated SQL.</value>
    Property pGeneratedSQL() As String
        Get
            Return GeneratedSQL
        End Get
        Set(ByVal tVal As String)
            GeneratedSQL = tVal
        End Set
    End Property
    ''' <summary>
    ''' Gets or sets a value indicating whether [p ck business].
    ''' </summary>
    ''' <value><c>true</c> if [p ck business]; otherwise, <c>false</c>.</value>
    Property pCkBusiness() As Boolean
        Get
            Return ckBusiness
        End Get
        Set(ByVal tVal As Boolean)
            ckBusiness = tVal
        End Set
    End Property
    ''' <summary>
    ''' Gets or sets a value indicating whether [p is admin].
    ''' </summary>
    ''' <value><c>true</c> if [p is admin]; otherwise, <c>false</c>.</value>
    Property pIsAdmin() As Boolean
        Get
            Return isAdmin
        End Get
        Set(ByVal tVal As Boolean)
            isAdmin = tVal
        End Set
    End Property
    ''' <summary>
    ''' Gets or sets a value indicating whether [p ck weighted].
    ''' </summary>
    ''' <value><c>true</c> if [p ck weighted]; otherwise, <c>false</c>.</value>
    Property pCkWeighted() As Boolean
        Get
            Return ckWeighted
        End Get
        Set(ByVal tVal As Boolean)
            ckWeighted = tVal
        End Set
    End Property
    ''' <summary>
    ''' Gets or sets a value indicating whether [p use existing records only].
    ''' </summary>
    ''' <value><c>true</c> if [p use existing records only]; otherwise, <c>false</c>.</value>
    Property pUseExistingRecordsOnly() As Boolean
        Get
            Return UseExistingRecordsOnly
        End Get
        Set(ByVal tVal As Boolean)
            UseExistingRecordsOnly = tVal
        End Set
    End Property
    ''' <summary>
    ''' Gets or sets a value indicating whether [p get count only].
    ''' </summary>
    ''' <value><c>true</c> if [p get count only]; otherwise, <c>false</c>.</value>
    Property pGetCountOnly() As Boolean
        Get
            Return getCountOnly
        End Get
        Set(ByVal tVal As Boolean)
            getCountOnly = tVal
        End Set
    End Property
    ''' <summary>
    ''' Gets or sets the p text search.
    ''' </summary>
    ''' <value>The p text search.</value>
    Property pTxtSearch() As String
        Get
            Return txtSearch$
        End Get
        Set(ByVal tVal As String)
            txtSearch$ = tVal
        End Set
    End Property


    ''' <summary>
    ''' Gens the email generated SQL.
    ''' </summary>
    ''' <param name="ckLimitToExisting">if set to <c>true</c> [ck limit to existing].</param>
    ''' <param name="txtThesaurus">The text thesaurus.</param>
    ''' <param name="cbThesaurusText">The cb thesaurus text.</param>
    ''' <param name="ckWeighted">if set to <c>true</c> [ck weighted].</param>
    ''' <param name="ckBusiness">if set to <c>true</c> [ck business].</param>
    ''' <param name="txtSearch">The text search.</param>
    ''' <param name="ckLimitToLib">if set to <c>true</c> [ck limit to library].</param>
    ''' <param name="LibraryName">Name of the library.</param>
    ''' <param name="MinWeight">The minimum weight.</param>
    ''' <param name="bIncludeAllLibs">if set to <c>true</c> [b include all libs].</param>
    ''' <param name="getCountOnly">if set to <c>true</c> [get count only].</param>
    ''' <param name="UseExistingRecordsOnly">if set to <c>true</c> [use existing records only].</param>
    ''' <param name="GeneratedSQL">The generated SQL.</param>
    ''' <returns>System.String.</returns>
    Function GenEmailGeneratedSQL(ByVal ckLimitToExisting As Boolean,
                                  ByVal txtThesaurus As String,
                                  ByVal cbThesaurusText As String,
                                  ByVal ckWeighted As Boolean,
                                  ByVal ckBusiness As Boolean,
                                  ByVal txtSearch As String,
                                  ByVal ckLimitToLib As Boolean,
                                  ByVal LibraryName As String,
                                  ByVal MinWeight As Integer,
                                  ByVal bIncludeAllLibs As Boolean,
                                  ByVal getCountOnly As Boolean,
                                  ByVal UseExistingRecordsOnly As Boolean,
                                  ByVal GeneratedSQL As String) As String
        'ByVal txtSearch as string, byval getCountOnly As Boolean, ByVal UseExistingRecordsOnly As Boolean, ByVal ckWeighted As Boolean, ByRef GeneratedSQL As String

        If txtSearch$ = Nothing Then
            LOG.WriteToSqlLog("All required variables not set to call this function.")
            'return ""
        Else

        End If
        If getCountOnly = Nothing Then
            getCountOnly = False
            'LOG.WriteToSqlLog("All required variables not set to call this function.")
            'return ""
        End If
        If UseExistingRecordsOnly = Nothing Then
            UseExistingRecordsOnly = False
            'LOG.WriteToSqlLog("All required variables not set to call this function.")
            'return ""
        Else
            UseExistingRecordsOnly = ckLimitToExisting
        End If
        If Not ckWeighted Then
            ckWeighted = False
        ElseIf ckWeighted Then
            ckWeighted = True
        ElseIf ckWeighted = Nothing Then
            ckWeighted = False
        End If
        If GeneratedSQL = Nothing Then
            'LOG.WriteToSqlLog("All required variables not set to call this function.")
            'return ""
        End If
        If gIsAdmin = False Then
            gIsAdmin = gIsGlobalSearcher
        End If
        If gIsAdmin = Nothing Then
            LOG.WriteToSqlLog("All required variables not set to call this function.")
            'return ""
        End If
        If ckBusiness = Nothing Then
            ckBusiness = False
        End If

        Dim EmailSql = ""
        Dim WhereClause$ = ""
        Dim bCopyToClipboard As Boolean = True

        Dim UserSql As String = genAdminEmailSql(isAdmin, ckLimitToLib, LibraryName)
        '**WDM Removed 7/12/2009 GeneratedSQL$ = genHeader()

        If getCountOnly Then
            GeneratedSQL$ += genEmailCountSql()
        Else
            GeneratedSQL$ += getEmailTblCols(ckWeighted, ckBusiness, txtSearch)
        End If


        GeneratedSQL$ = GeneratedSQL$ + " WHERE " + vbCrLf


        Dim ContainsClause$ = ""
        ContainsClause = genContainsClause(txtSearch, ckBusiness, ckWeighted, True, ckLimitToExisting, ThesaurusList, txtThesaurus, cbThesaurusText, "EMAIL")

        If ContainsClause.Length > 0 Then
            GeneratedSQL$ = GeneratedSQL$ + vbCrLf + ContainsClause
        End If


        If bCopyToClipboard Then
            Dim tClip$ = "/* WhereClause$ */ " + vbCrLf
            tClip += WhereClause$
        End If

        EmailSql = GeneratedSQL$ + vbCrLf
        If bCopyToClipboard Then
            Dim tClip$ = "/* ContainsClause */ " + vbCrLf
            tClip += EmailSql
        End If


        If ContainsClause.Trim.Length > 0 Then

            EmailSql = GeneratedSQL$ + vbCrLf
            EmailSql += " " + vbCrLf + WhereClause + vbCrLf

            If getCountOnly Then
                EmailSql += UserSql
            Else
                EmailSql += vbCrLf + UserSql

                If ckWeighted = True Then
                    'EmailSql += " and KEY_TBL.RANK >= " + MinRating.ToString + vbCrLf
                    'EmailSql += vbCrLf + " ORDER BY KEY_TBL.RANK DESC "

                    '**WDM 6/1/2008 EmailSql += " /* and KEY_TBL.RANK >= " + MinRating.ToString + " */" + vbCrLf
                    EmailSql += "    and KEY_TBL.RANK >= " + MinRating.ToString + vbCrLf

                    Dim IncludeEmailAttachmentsQry As String = EmailSql + vbCrLf
                    'If ckIncludeAttachments.Checked Then
                    Dim ckIncludeAttachments As Boolean = True

                    'If ckWeighted = True Then
                    '    IncludeEmailAttachmentsSearchWeighted(ckIncludeAttachments, ckWeighted, ckBusiness, txtSearch, ckLimitToExisting, txtThesaurus, cbThesaurusText, MinWeight)
                    'Else
                    '    IncludeEmailAttachmentsSearch(ckIncludeAttachments, ckWeighted, ckBusiness, txtSearch, ckLimitToExisting, txtThesaurus, cbThesaurusText, LibraryName$, bIncludeAllLibs)
                    'End If

                    If ckIncludeAttachments = True And ckLimitToLib = False Then
                        '** ECM EmailAttachmentSearchList
                        If gMasterContentOnly = True Then
                        Else
                            'IncludeEmailAttachmentsQry$ = vbCrLf + " OR " + "([EmailGuid] in (select EmailGuid from EmailAttachmentSearchList where UserID = '" + gCurrUserGuidID + "'))" + vbCrLf
                        End If

                        'EmailSql = EmailSql + vbCrLf + IncludeEmailAttachmentsQry$ + vbCrLf
                        EmailSql = EmailSql + genUseExistingRecordsOnly(UseExistingRecordsOnly, "EmailGuid")

                        'Clipboard.Clear()
                        'Clipboard.SetText(EmailSql)
                    End If
                    'EmailSql += vbCrLf + " or isPublic = 'Y' "
                    EmailSql += vbCrLf + " ORDER BY KEY_TBL.RANK DESC " + vbCrLf

                Else
                    Dim IncludeEmailAttachmentsQry$ = EmailSql + vbCrLf
                    'If ckIncludeAttachments.Checked Then
                    Dim ckIncludeAttachments As Boolean = True
                    IncludeEmailAttachmentsSearch(ckIncludeAttachments, ckWeighted, ckBusiness, txtSearch, ckLimitToExisting, txtThesaurus, cbThesaurusText, LibraryName$, bIncludeAllLibs)
                    'If ckIncludeAttachments = True And ckLimitToLib = False Then
                    '    '** ECM EmailAttachmentSearchList
                    '    If gMasterContentOnly = True Then
                    '    Else
                    '        IncludeEmailAttachmentsQry$ = vbCrLf + " OR " + "([EmailGuid] in (select EmailGuid from EmailAttachmentSearchList where UserID = '" + gCurrUserGuidID + "'))" + vbCrLf
                    '    End If

                    '    EmailSql = EmailSql + vbCrLf + IncludeEmailAttachmentsQry$ + vbCrLf
                    '    EmailSql = EmailSql + genUseExistingRecordsOnly(UseExistingRecordsOnly, "EmailGuid")
                    'End If
                    'EmailSql += vbCrLf + " or isPublic = 'Y' "
                    EmailSql += vbCrLf + " order by [ShortSubj] "
                End If
            End If
        Else
            EmailSql = ""
        End If
        If bCopyToClipboard Then
            Dim tClip$ = "/* Final */ " + vbCrLf
            tClip += EmailSql
        End If

        ValidateNotClauses(EmailSql)
        DMA.ckFreetextRemoveOr(EmailSql, "freetext ((Body, Description, KeyWords, Subject, Attachment, Ocrtext)")
        DMA.ckFreetextRemoveOr(EmailSql, "freetext (body")
        DMA.ckFreetextRemoveOr(EmailSql, "freetext (subject")

        Return EmailSql
    End Function
    ''' <summary>
    ''' Subs the in.
    ''' </summary>
    ''' <param name="ParentString">The parent string.</param>
    ''' <param name="WhatToChange">The what to change.</param>
    ''' <param name="ChangeCharsToThis">The change chars to this.</param>
    Sub SubIn(ByRef ParentString As String, ByVal WhatToChange As String, ByVal ChangeCharsToThis As String)
        Dim I As Integer = 0
        Dim J As Integer = 0
        Dim M As Integer = 0
        Dim N As Integer = 0
        Dim S1$ = ""
        Dim S2$ = ""


        M = WhatToChange$.Length
        N = ChangeCharsToThis$.Length


        Do While InStr(ParentString, WhatToChange, CompareMethod.Text) > 0
            I = InStr(ParentString, WhatToChange, CompareMethod.Text)
            S1 = Mid(ParentString, 1, I - 1)
            S2 = Mid(ParentString, I + M)
            Dim NewLine$ = S1 + ChangeCharsToThis + S2
            ParentString = NewLine
        Loop
    End Sub
    ''' <summary>
    ''' Skips to next token.
    ''' </summary>
    ''' <param name="S">The s.</param>
    ''' <param name="I">The i.</param>
    Sub SkipToNextToken(ByVal S As String, ByRef I As Integer)
        Dim Delimiters As String = " ,:+-^|"
        S = S.Trim
        Dim Token = ""
        Dim CH$ = ""
        CH = Mid(S, I, 1)
        Dim KK As Integer = S.Length


        Token = ""
        I += 1
        CH = Mid(S, I, 1)
        KK = S.Length
        If CH.Length > 0 And InStr(Delimiters, CH) = 0 Then
            Return
        End If
        If CH.Equals("-") Then
            Return
        End If
        If CH.Equals("^") Then
            Return
        End If
        If CH.Equals("~") Then
            Return
        End If
        If CH.Equals("+") Then
            Return
        End If
        If CH.Equals("|") Then
            Return
        End If
        Do Until (InStr(Delimiters, CH) = 0 And I <= KK)
            Token += CH
            I += 1
            CH = Mid(S, I, 1)
            LOG.WriteToSqlLog(Token)
            If I > S.Length Then
                Exit Do
            End If
        Loop


    End Sub
    ''' <summary>
    ''' Gets the next token.
    ''' </summary>
    ''' <param name="S">The s.</param>
    ''' <param name="I">The i.</param>
    ''' <param name="ReturnedDelimiter">The returned delimiter.</param>
    ''' <returns>System.String.</returns>
    Function getNextToken(ByVal S As String, ByRef I As Integer, ByRef ReturnedDelimiter As String) As String
        Dim Delimiters As String = " ,:+-^|()"
        S = S.Trim
        Dim Token = ""
        Dim CH$ = ""
        CH = Mid(S, I, 1)
        Dim KK As Integer = S.Length


        '** If CH is a blank char, skip to the start of the next token
        If CH = " " Then
            Do Until (CH <> " " And I <= KK)
                I += 1
                CH = Mid(S, I, 1)
            Loop
        End If


        If CH = ChrW(34) Then
            Token = ""
            Token += ChrW(34)
            I += 1
            CH = Mid(S, I, 1)
            KK = S.Length
            Do Until (CH = ChrW(34) And I <= KK)
                Token += CH
                I += 1
                CH = Mid(S, I, 1)
                If I > S.Length Then
                    Exit Do
                End If
            Loop
            Token += ChrW(34)
            'WDM May need to put back I += 1
        Else
            Token = CH
            I += 1
            CH = Mid(S, I, 1)
            KK = S.Length
            Do Until (InStr(Delimiters, CH) > 0 And I <= KK)
                Token += CH
                I += 1
                CH = Mid(S, I, 1)
                ReturnedDelimiter$ = CH
                If I > S.Length Then
                    Exit Do
                End If
            Loop
            'WDM May need to put back I += 1
        End If
        Return Token
    End Function
    ''' <summary>
    ''' Gets the rest of the token.
    ''' </summary>
    ''' <param name="S">The s.</param>
    ''' <param name="I">The i.</param>
    ''' <returns>System.String.</returns>
    Function getTheRestOfTheToken(ByVal S As String, ByRef I As Integer) As String
        'We are sitting at the next character in the token, so go back to the beginning
        I = I - 1
        Dim Delimiters As String = " ,:+-^|"
        S = S.Trim
        Dim Token = ""
        Dim CH$ = ""
        CH = Mid(S, I, 1)
        Dim KK As Integer = S.Length


        '** If CH is a blank char, skip to the start of the next token
        If CH = " " Then
            Do Until (CH <> " " And I <= KK)
                I += 1
                CH = Mid(S, I, 1)
            Loop
        End If


        If CH = ChrW(34) Then
            Token = ""
            Token += ChrW(34)
            I += 1
            CH = Mid(S, I, 1)
            KK = S.Length
            Do Until (CH = ChrW(34) And I <= KK)
                Token += CH
                I += 1
                CH = Mid(S, I, 1)
                If I > S.Length Then
                    Exit Do
                End If
            Loop
            Token += ChrW(34)
            I += 1
        Else
            Token = CH
            I += 1
            CH = Mid(S, I, 1)
            KK = S.Length
            Do Until (InStr(Delimiters, CH) > 0 And I <= KK)
                Token += CH
                I += 1
                CH = Mid(S, I, 1)
                If I > S.Length Then
                    Exit Do
                End If
            Loop
            I += 1
        End If
        Return Token
    End Function
    ''' <summary>
    ''' Gets the token.
    ''' </summary>
    ''' <param name="I">The i.</param>
    ''' <param name="k">The k.</param>
    ''' <param name="tStr">The t string.</param>
    Sub GetToken(ByVal I As Integer, ByRef k As Integer, ByVal tStr As String)
        Dim X As Integer = tStr.Trim.Length
        Dim CH As String = ""
        Dim Alphabet$ = " |+-^"
        For I = I To X
            CH = Mid(tStr, I, 1)
            If InStr(1, Alphabet, CH, CompareMethod.Text) > 0 Then
                'We found the next word
            End If
        Next
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
            Case "AND"
                Return True
        End Select
        Return B
    End Function
    ''' <summary>
    ''' Translates the delimiter.
    ''' </summary>
    ''' <param name="CH">The ch.</param>
    ''' <param name="Translateddel">The translateddel.</param>
    Sub TranslateDelimiter(ByVal CH As String, ByRef Translateddel As String)
        Translateddel$ = ""
        Select Case CH
            Case "+"
                Translateddel$ = "And"
            Case "-"
                Translateddel$ = "Not"
            Case "|"
                Translateddel$ = "Or"
        End Select
    End Sub
    ''' <summary>
    ''' Gets the quoted string.
    ''' </summary>
    ''' <param name="tstr">The TSTR.</param>
    ''' <param name="i">The i.</param>
    ''' <param name="j">The j.</param>
    ''' <param name="QuotedString">The quoted string.</param>
    Sub GetQuotedString(ByVal tstr As String, ByRef i As Integer, ByRef j As Integer, ByRef QuotedString As String)
        Dim X As Integer = tstr.Trim.Length
        Dim Q$ = ChrW(34)
        Dim CH As String = ""
        Dim Alphabet$ = " |+-^"
        Dim S As String = ""
        QuotedString$ = Q
        i += 1
        CH = Mid(tstr, i, 1)
        Do While CH <> ChrW(34) And i <= tstr.Length
            QuotedString$ = QuotedString$ + CH
            i += 1
            CH = Mid(tstr, i, 1)
        Loop
        QuotedString$ = QuotedString$ + Q
    End Sub
    ''' <summary>
    ''' Skips the tokens.
    ''' </summary>
    ''' <param name="tstr">The TSTR.</param>
    ''' <param name="i">The i.</param>
    ''' <param name="j">The j.</param>
    Sub SkipTokens(ByVal tstr As String, ByVal i As Integer, ByRef j As Integer)
        Dim X As Integer = tstr.Trim.Length
        Dim Q$ = ChrW(34)
        Dim CH As String = ""
        Dim Alphabet$ = " |+-^"
        Dim S As String = ""
        For j = i + 1 To X
            CH = Mid(tstr, j, 1)
            If InStr(1, Alphabet, CH) = 0 Then
                Exit For
                'We found the string
            End If
        Next
    End Sub
    ''' <summary>
    ''' Determines whether [is not delimiter] [the specified ch].
    ''' </summary>
    ''' <param name="CH">The ch.</param>
    ''' <returns><c>true</c> if [is not delimiter] [the specified ch]; otherwise, <c>false</c>.</returns>
    Function isNotDelimiter(ByVal CH As String) As Boolean
        Dim Alphabet$ = " |+-^"
        If InStr(1, Alphabet, CH) = 0 Then
            Return True
        Else
            Return False
        End If
    End Function
    ''' <summary>
    ''' Determines whether the specified ch is delimiter.
    ''' </summary>
    ''' <param name="CH">The ch.</param>
    ''' <returns><c>true</c> if the specified ch is delimiter; otherwise, <c>false</c>.</returns>
    Function isDelimiter(ByVal CH As String) As Boolean
        Dim Alphabet$ = " |+-^"
        If InStr(1, Alphabet, CH) > 0 Then
            Return True
        Else
            Return False
        End If
    End Function
    ''' <summary>
    ''' Determines whether [is syntax character] [the specified ch].
    ''' </summary>
    ''' <param name="CH">The ch.</param>
    ''' <returns><c>true</c> if [is syntax character] [the specified ch]; otherwise, <c>false</c>.</returns>
    Function isSyntaxChar(ByVal CH As String) As Boolean
        Dim Alphabet$ = "#|+-^~"
        If InStr(1, Alphabet, CH) > 0 Then
            Return True
        Else
            Return False
        End If
    End Function
    ''' <summary>
    ''' Builds the contains syntax.
    ''' </summary>
    ''' <param name="SearchCriteria">The search criteria.</param>
    ''' <param name="ThesaurusWords">The thesaurus words.</param>
    ''' <returns>System.String.</returns>
    Function buildContainsSyntax(ByVal SearchCriteria As String, ByRef ThesaurusWords As List(Of String)) As String
        '** Get all the OR'SearchCriteria and build a search term then
        '** get all the AND'SearchCriteria and build a search term then
        '** Apply any NEAR'SearchCriteria to the mess.


        ' "dale miller" "susan miller" near Jessie
        ' "dale miller" "susan miller" +Jessie Shelby
        ' "dale miller" +"susan miller" +Jessie
        'Dale Susan near Jessie
        '+dale +susan near Jessie
        '+dale +susan Jessie
        '+dale +susan +Jessie


        'WHERE CONTAINS(*, '"ECA" or "Enterprise Content" AND "Content*" and "state" NEAR "State Farm"')
        '** '"ECA" or "Enterprise Content" AND "Content*" and "state" NEAR "State Farm" and "Corporate"'
        '** 'ECA or "Enterprise Content" AND Content* and state NEAR "State Farm" and Corporate'
        '** 'ECA "Enterprise Content" +Content* +state NEAR "State Farm" +Corporate'
        '** WHERE CONTAINS(Description, ' FORMSOF (INFLECTIONAL, ride) ');


        Dim A As New List(Of String)
        Dim I As Integer = 0
        Dim J As Integer = 0
        Dim Ch$ = ""
        Dim tWord$ = ""
        Dim WordCnt As Integer = 0
        Dim isOr As Boolean = False
        Dim isAnd As Boolean = False
        Dim isNear As Boolean = False
        Dim isPhrase As Boolean = False
        Dim isAndNot As Boolean = False
        Dim Delimiters As String = " ,:"
        Dim DQ As String = ChrW(34)
        Dim FirstEntry As Boolean = True
        Dim QuotedString$ = ""
        Dim OrNeeded As Boolean = False
        Dim AndNeeded As Boolean = False

        ThesaurusWords.Clear()

        SearchCriteria = SearchCriteria.Trim


        For I = 1 To SearchCriteria.Length


StartNextWord:
            Ch = Mid(SearchCriteria, I, 1)
            If FirstEntry Then
                If Ch.Equals("~") Or Ch.Equals("^") Or Ch.Equals("^") Or Ch.Equals("#") Then
                    '** DO nothing - it belongs here
                Else
                    If isDelimiter(Ch) Then
                        SkipTokens(SearchCriteria, I, J)
                        I = J
                        GoTo StartNextWord
                    End If
                End If

                FirstEntry = False
            End If
TokenAlreadyAcquired:
            If Ch = ChrW(34) Then
                QuotedString$ = ""
                J = 0
                GetQuotedString(SearchCriteria, I, J, QuotedString)
                If QuotedString$.Equals(ChrW(34) + ChrW(34)) Then
                    If gDebug Then Console.WriteLine("Skipping null double quotes.")
                Else
                    A.Add(QuotedString)
                End If

                OrNeeded = True
            ElseIf Ch.Equals("|") Then
                OrNeeded = False
                A.Add("Or")
            ElseIf Ch.Equals("+") Then
                A.Add("And")
                OrNeeded = False
            ElseIf Ch.Equals("-") Then
                A.Add("Not")
                OrNeeded = False
            ElseIf Ch.Equals("(") Then
                If gDebug Then Console.WriteLine("Skipping: " + Ch)
                A.Add("(")
            ElseIf Ch.Equals(")") Then
                If gDebug Then Console.WriteLine("Skipping: " + Ch)
                A.Add(")")
            ElseIf Ch.Equals(",") Then
                If gDebug Then Console.WriteLine("Skipping: " + Ch)
            ElseIf Ch = "^" Then
                '** Then this will be an inflectional term
                '** One term using the AND operator will be built for each inflectional term provided.
                Dim SubstituteString As String = "FORMSOF (INFLECTIONAL, " + ChrW(34) + "@" + ChrW(34) + ")"
                I += 1

                Dim ReturnedDelimiter$ = ""

                tWord = getNextToken(SearchCriteria, I, ReturnedDelimiter)
                Dim C$ = Mid(SearchCriteria, I, 1)
                SubIn(SubstituteString, "@", tWord)
                tWord = SubstituteString
                SubIn(tWord, ChrW(34) + ChrW(34), ChrW(34))

                If OrNeeded Then
                    A.Add("Or")
                End If

                If gDebug Then Console.WriteLine(I.ToString + ":" + Mid(SearchCriteria, I, 1))
                A.Add(tWord)
                OrNeeded = True
                tWord = ""
                GoTo StartNextWord
            ElseIf Ch = "~" Then
                '** Then this will be an THESAURUS term
                '** One term using the AND operator will be built for each inflectional term provided.
                Dim SubstituteString As String = "FORMSOF (THESAURUS, " + ChrW(34) + "@" + ChrW(34) + ")"
                I += 1
                Dim ReturnedDelimiter$ = ""
                tWord = getNextToken(SearchCriteria, I, ReturnedDelimiter)
                SubIn(SubstituteString, "@", tWord)
                tWord = SubstituteString
                SubIn(tWord, ChrW(34) + ChrW(34), ChrW(34))
                'If A.Count > 1 Then
                '    A.Add("AND")
                '    OrNeeded = False
                'End If
                If OrNeeded Then
                    A.Add("Or")
                End If
                If gDebug Then Console.WriteLine(I.ToString + ":" + Mid(SearchCriteria, I, 1))
                A.Add(tWord)
                OrNeeded = True
                tWord = ""
                GoTo StartNextWord
            ElseIf Ch = "#" Then
                '** Then this will be an THESAURUS term
                '** One term using the AND operator will be built for each inflectional term provided.
                Dim SubstituteString As String = "FORMSOF (THESAURUS, " + ChrW(34) + "@" + ChrW(34) + ")"
                I += 1
                Dim ReturnedDelimiter$ = ""
                tWord = getNextToken(SearchCriteria, I, ReturnedDelimiter)
                If Not ThesaurusWords.Contains(tWord) Then
                    ThesaurusWords.Add(tWord)
                End If
                GoTo ProcessImmediately
            ElseIf Ch = " " Or Ch = "," Then
                I += 1
                Ch = Mid(SearchCriteria, I, 1)
                If isSyntaxChar(Ch) Then
                    GoTo TokenAlreadyAcquired
                End If
                Do While Ch = " " And I < SearchCriteria.Length
                    Ch = Mid(SearchCriteria, I, 1)
                    I += 1
                Loop
                If isSyntaxChar(Ch) Then
                    I = I - 1
                    GoTo TokenAlreadyAcquired
                End If
                isOr = True
                tWord = getTheRestOfTheToken(SearchCriteria, I)
                If gDebug Then Console.WriteLine(tWord)
                A.Add(tWord)
                Dim BB As Boolean = False
                BB = isKeyWord(tWord)


                If BB = True Then
                    OrNeeded = False
                Else
                    OrNeeded = True
                End If
                tWord = ""
                I = I - 1
            Else
                Dim ReturnedDelimiter$ = ""
                tWord = getNextToken(SearchCriteria, I, ReturnedDelimiter)
                If gDebug Then Console.WriteLine(tWord)
                A.Add(tWord)
                If UCase(tWord).Equals("OR") Then
                    OrNeeded = False
                ElseIf UCase(tWord).Equals("AND") Then
                    OrNeeded = False
                ElseIf UCase(tWord).Equals("NOT") Then
                    OrNeeded = False
                Else
                    OrNeeded = True
                End If


                tWord = ""
                I = I - 1
            End If
ProcessImmediately:


            If gDebug Then Console.WriteLine(I.ToString + ":" + tWord)
            If gDebug Then Console.WriteLine(SearchCriteria)
            tWord = ""
            'isOr = True
            For II As Integer = 0 To A.Count - 1
                If A(II) = Nothing Then
                    If gDebug Then Console.WriteLine(II.ToString + ":Nothing")
                Else
                    If gDebug Then Console.WriteLine(II.ToString + ":" + A(II).ToString)
                End If
            Next
NextWord:
        Next

        Dim XX As Integer = A.Count
        For XX = A.Count() - 1 To 0 Step -1
            tWord$ = A(XX).Trim
            If Me.isKeyWord(tWord) Then
                A.RemoveAt(XX)
            Else
                Exit For
            End If
        Next
        Dim Stmt$ = ""
        For I = 0 To A.Count - 1
            If I = A.Count - 1 Then
                tWord$ = A(I).Trim
                If Me.isKeyWord(tWord) Then
                    If gDebug Then Console.WriteLine("Do nothing")
                Else
                    Stmt = Stmt + " " + A(I)
                    If gDebug Then Console.WriteLine(I.ToString + ": " + Stmt)
                End If
            Else
                Stmt = Stmt + " " + A(I)
                If gDebug Then Console.WriteLine(I.ToString + ": " + Stmt)
            End If

        Next
        Return Stmt


    End Function

    ''' <summary>
    ''' Gets the thesaurus words.
    ''' </summary>
    ''' <param name="ThesaurusList">The thesaurus list.</param>
    ''' <param name="ThesaurusWords">The thesaurus words.</param>
    Sub getThesaurusWords(ByVal ThesaurusList As List(Of String), ByRef ThesaurusWords As List(Of String))
        gettingThesaurusWords = True
        Dim AllWords$ = ""
        Dim ThesaurusName As String = ""

        If gThesauri.Count = 1 Then
            For kk As Integer = 0 To gThesauri.Count - 1
                ThesaurusName = gThesauri(kk).ToString
                ThesaurusList.Add(ThesaurusName)
            Next
            ''FrmMDIMain.SB.Text = "Custom thesauri used"
        ElseIf gThesauri.Count > 0 Then
            For kk As Integer = 0 To gThesauri.Count - 1
                ThesaurusName = gThesauri(kk).ToString
                ThesaurusList.Add(ThesaurusName)
            Next
            ''FrmMDIMain.SB.Text = "Custom thesauri used"
        End If

        If ThesaurusList.Count = 0 Then
            '** Get and use the default Thesaurus'
            If gClipBoardActive Then Console.WriteLine("No thesauri specified - using default.")
            '** System parms MUST b loaded at startup time - we need a "Startup" splash screen that can be used for rebranding and loading all the intialization parameters.
            'ThesaurusName = DB.getSystemParm("Default Thesaurus")
            'If ThesaurusName.Equals("NA") Then
            'Return ""
            'Else
            '  ThesaurusList.Add(ThesaurusName)
            'End If
            ThesaurusList.Add("Roget")
        End If

        '** Get and use the default Thesaurus
        For Each T As String In ThesaurusList
            ThesaurusName = T

            'AddHandler ProxySearch.getThesaurusIDCompleted, AddressOf client_getThesaurusID
            'EP.setSearchSvcEndPoint(proxy)
            Dim SS As String = ProxySearch.getThesaurusID(gSecureID, ThesaurusName)
            client_getThesaurusID(SS)
        Next


    End Sub

    ''' <summary>
    ''' Clients the get thesaurus identifier.
    ''' </summary>
    ''' <param name="SS">The ss.</param>
    Sub client_getThesaurusID(SS As String)

        ExpandedWords.Clear()

        If SS.Length > 0 Then
            Dim ThesaurusID As String = SS
            Dim lExpandedWords As String = ""
            For Each token As String In ThesaurusWords
                If Not ExpandedWords.Contains(token) Then
                    ExpandedWords.Add(token)
                End If
                'Dim proxy As New SVCSearch.Service1Client
                lExpandedWords += lExpandedWords + "|"
                Dim S As String = ProxySearch.getSynonyms(gSecureID, ThesaurusID, token, lExpandedWords)
                client_getSynonyms(S)
            Next

        Else
            gErrorCount += 1
            LOG.WriteToSqlLog("ERROR clsSql- client_getThesaurusID 100: ")
        End If
        'RemoveHandler ProxySearch.getThesaurusIDCompleted, AddressOf client_getThesaurusID
    End Sub

    ''' <summary>
    ''' Clients the get synonyms.
    ''' </summary>
    ''' <param name="S">The s.</param>
    Sub client_getSynonyms(S As String)
        Dim words() As String = Nothing
        ExpandedWords.Clear()
        If S.Length > 0 Then
            'ExpandedWords = e.lbSynonyms
            words = S.Split(",")
            For Each SS As String In words
                Dim tWord As String = SS
                ExpandedWords.Add(S)
                tWord = tWord.Trim
                If InStr(tWord, ChrW(34)) = 0 Then
                    tWord = ChrW(34) + tWord + ChrW(34)
                End If
                ListOfPhrases$ = ListOfPhrases$ + ChrW(9) + tWord + " or " + vbCrLf
            Next
            If ListOfPhrases$ = Nothing Then

            Else
                ListOfPhrases$ = ListOfPhrases$.Trim
                ListOfPhrases$ = Mid(ListOfPhrases$, 1, ListOfPhrases$.Length - 3)
            End If
            gettingThesaurusWords = False
        Else
            LOG.WriteToSqlLog("ERROR client_getSynonyms 100: ")
            ExpandedWords.Clear()
        End If
    End Sub
    ''' <summary>
    ''' Validates the contains list.
    ''' </summary>
    ''' <param name="ContainsList">The contains list.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function ValidateContainsList(ByRef ContainsList As String) As Boolean
        ContainsList$ = ContainsList$.Trim
        If ContainsList.Trim.Length = 0 Then
            Return False
        End If
        If isKeyWord(ContainsList) Then
            Return False
        End If
        Dim b As Boolean = True
        If InStr(ContainsList, "body, ' ')", CompareMethod.Text) > 0 Then
            '** It is a null where clause in effect
            ContainsList = ""
            b = False
        End If
        If InStr(ContainsList, "body, ' or", CompareMethod.Text) > 0 Then
            '** It is a null where clause in effect
            ContainsList = ""
            b = False
        End If
        If InStr(ContainsList, "body, ' and", CompareMethod.Text) > 0 Then
            '** It is a null where clause in effect
            ContainsList = ""
            b = False
        End If
        Return b
    End Function
    ''' <summary>
    ''' Populates the thesaurus list.
    ''' </summary>
    ''' <param name="ThesaurusList">The thesaurus list.</param>
    ''' <param name="ThesaurusWords">The thesaurus words.</param>
    ''' <param name="txtThesaurus">The text thesaurus.</param>
    ''' <param name="cbThesaurusText">The cb thesaurus text.</param>
    ''' <returns>System.String.</returns>
    Function PopulateThesaurusList(ByVal ThesaurusList As List(Of String), ByRef ThesaurusWords As List(Of String), ByVal txtThesaurus As String, ByVal cbThesaurusText As String) As String

        Dim A1$(0)
        Dim A2$(0)
        Dim Token = ""
        Dim ExpandedWords$ = ""

        If InStr(1, txtThesaurus, ",") > 0 Then
            A1 = txtThesaurus.Split(",")
        Else
            A1(0) = txtThesaurus
        End If

        For i As Integer = 0 To UBound(A1)
            Token = A1(i).Trim
            If InStr(Token, ChrW(34)) > 0 Then
                ThesaurusWords.Add(Token)
            Else
                A2 = Token.Split(" ")
                For ii As Integer = 0 To UBound(A2)
                    ThesaurusWords.Add(A2(ii).Trim)
                Next
            End If

        Next

        getThesaurusWords(ThesaurusList, ThesaurusWords)

        Return ExpandedWords$

    End Function
    ''' <summary>
    ''' Gens the contains clause.
    ''' </summary>
    ''' <param name="InputSearchString">The input search string.</param>
    ''' <param name="useFreetext">if set to <c>true</c> [use freetext].</param>
    ''' <param name="ckWeighted">if set to <c>true</c> [ck weighted].</param>
    ''' <param name="isEmail">if set to <c>true</c> [is email].</param>
    ''' <param name="LimitToCurrRecs">if set to <c>true</c> [limit to curr recs].</param>
    ''' <param name="ThesaurusList">The thesaurus list.</param>
    ''' <param name="txtThesaurus">The text thesaurus.</param>
    ''' <param name="cbThesaurusText">The cb thesaurus text.</param>
    ''' <param name="calledBy">The called by.</param>
    ''' <returns>System.String.</returns>
    Function genContainsClause(ByVal InputSearchString As String,
                               ByVal useFreetext As Boolean,
                               ByVal ckWeighted As Boolean,
                               ByVal isEmail As Boolean,
                               ByVal LimitToCurrRecs As Boolean,
                               ByVal ThesaurusList As List(Of String),
                               ByVal txtThesaurus As String,
                               ByVal cbThesaurusText As String, ByVal calledBy As String) As String

        Dim WhereClause$ = ""
        Dim S As String = ""
        'Dim ThesaurusList As New list(of string)
        Dim ThesaurusWords As New List(Of String)
        Dim ContainsClause$ = ""
        Dim isValidContainsClause As Boolean = False
        Dim lParens As Integer = 0
        Dim rParens As Integer = 0

        If InputSearchString$.Length = 0 Then
            '** NO Search criteria was specified send back something that will return everything
            If calledBy.Equals("EMAIL") Then
                WhereClause$ = " UserID is not null "
            Else
                WhereClause$ = " DataSourceOwnerUserID is not null "
            End If
            Return WhereClause$
        End If

        If ckWeighted Then

            If InputSearchString$.Length = 0 Then
                If gIsAdmin Or gIsGlobalSearcher Then
                    ContainsClause$ = " DataSourceOwnerUserID is not null "
                Else
                    ContainsClause$ = " DataSourceOwnerUserID = '" + gCurrUserGuidID + "' "
                End If

            Else
                ContainsClause$ = buildContainsSyntax(InputSearchString$, ThesaurusWords)
            End If


            isValidContainsClause = ValidateContainsList(ContainsClause)

            If isEmail Then
                If useFreetext = True Then
                    '** This is FREETEXT searching, remove noise words                    
                    UTIL.RemoveFreetextStopWords(InputSearchString)
                    If InputSearchString$.Length > 0 Or txtThesaurus.Trim.Length > 0 Then
                        If isValidContainsClause Then
                            '(Body, Description, KeyWords, Subject, Attachment, Ocrtext)
                            WhereClause += " ( FREETEXT ((Body, SUBJECT, KeyWords, Description), '"
                            S$ = InputSearchString$
                            WhereClause += buildContainsSyntax(S$, ThesaurusWords)
                            WhereClause += "') "
                            rParens += 1
                        End If

                        If txtThesaurus.Trim.Length > 0 Then
                            Dim ExpandedWordList As String = PopulateThesaurusList(ThesaurusList, ThesaurusWords, txtThesaurus, cbThesaurusText)
                            If ExpandedWordList.Trim.Length > 0 Then
                                WhereClause += vbCrLf + ChrW(9) + cbThesaurusText + " FREETEXT ((Body, SUBJECT, KeyWords, Description), '" + ExpandedWordList
                                WhereClause += "')" + vbCrLf + "/* 0A1 */ " + vbCrLf
                                rParens += 1
                            End If
                        End If

                        '** 5/29/2008 by WDM now, get the SUBJECT searched too.
                        If isValidContainsClause Then
                            WhereClause += " or FREETEXT ((Body, SUBJECT, KeyWords, Description), '"
                            S$ = InputSearchString$
                            WhereClause += buildContainsSyntax(S$, ThesaurusWords)
                            WhereClause += "') " + vbCrLf + " /* 00 */ " + vbCrLf
                            rParens += 1
                        End If

                        If txtThesaurus.Trim.Length > 0 Then
                            Dim ExpandedWordList As String = PopulateThesaurusList(ThesaurusList, ThesaurusWords, txtThesaurus, cbThesaurusText)
                            If ExpandedWordList.Trim.Length > 0 Then
                                WhereClause += vbCrLf + ChrW(9) + " OR FREETEXT ((Body, SUBJECT, KeyWords, Description), '" + ExpandedWordList
                                WhereClause += "') "
                                rParens += 1
                            End If
                        End If
                        WhereClause += ")" + vbCrLf + "  /* #2 */" + vbCrLf
                    End If
                Else
                    'Processing a weighted set of documents
                    lParens = 0
                    If InputSearchString$.Length > 0 Or txtThesaurus.Trim.Length > 0 Then
                        WhereClause += " ( CONTAINS(BODY, '"
                        S$ = InputSearchString$
                        WhereClause += buildContainsSyntax(S$, ThesaurusWords)
                        WhereClause += "')   /*YY00a*/ " + vbCrLf

                        lParens = lParens + 1

                        If txtThesaurus.Trim.Length > 0 Then
                            Dim ExpandedWordList As String = PopulateThesaurusList(ThesaurusList, ThesaurusWords, txtThesaurus, cbThesaurusText)
                            If ExpandedWordList.Trim.Length > 0 Then
                                WhereClause = WhereClause + vbCrLf
                                WhereClause += vbCrLf + ChrW(9) + cbThesaurusText + " (CONTAINS (body, '" + ExpandedWordList
                                WhereClause += "')   /*YY00*/" + vbCrLf
                                lParens = lParens + 1
                            End If
                        End If

                        WhereClause += " or CONTAINS(SUBJECT, '"
                        S$ = InputSearchString$
                        WhereClause += buildContainsSyntax(S$, ThesaurusWords)
                        WhereClause += "')   /*XX01*/" + vbCrLf

                        If txtThesaurus.Trim.Length > 0 Then
                            getThesaurusWords(ThesaurusList, ThesaurusWords)
                            Dim ExpandedThesaurusWords As String = ""
                            For IX As Integer = 0 To ThesaurusList.Count - 1
                                ExpandedThesaurusWords += ThesaurusList.Item(IX) + " "
                            Next

                            Dim ExpandedWordList As String = PopulateThesaurusList(ThesaurusList, ThesaurusWords, txtThesaurus, cbThesaurusText)
                            If ExpandedWordList.Trim.Length > 0 Then
                                WhereClause = WhereClause + vbCrLf
                                WhereClause += vbCrLf + ChrW(9) + cbThesaurusText + " (CONTAINS (subject, '" + ExpandedThesaurusWords
                                WhereClause += "')   /*YY01*/" + vbCrLf
                                lParens = lParens + 1
                            End If
                        End If
                        If lParens = 1 Then
                            WhereClause += ")     /*XX02a*/" + vbCrLf
                        ElseIf lParens = 2 Then
                            WhereClause += "))     /*XX02b*/" + vbCrLf
                        ElseIf lParens = 3 Then
                            WhereClause += ")))     /*XX02c*/" + vbCrLf
                        End If
                    End If
                End If
            Else
                '** Processing documents, not emails
                If useFreetext = True Then
                    If InputSearchString$.Length > 0 Or txtThesaurus.Trim.Length > 0 Then
                        Console.WriteLine("FIX THIS NOW - 200.22a")
                        'DB.RemoveFreetextStopWords(InputSearchString  )
                        'DB.RemoveFreetextStopWords(txtThesaurus  )
                        'WhereClause += " FREETEXT (SourceImage, '"
                        'WhereClause += " FREETEXT (DataSource.*, '"
                        WhereClause += " FREETEXT ((Description, KeyWords, Notes, SourceImage, SourceName), '"
                        S$ = InputSearchString$
                        WhereClause += buildContainsSyntax(S$, ThesaurusWords)
                        WhereClause += "')"

                        If txtThesaurus.Trim.Length > 0 Then
                            Dim ExpandedWordList As String = PopulateThesaurusList(ThesaurusList, ThesaurusWords, txtThesaurus, cbThesaurusText)
                            If ExpandedWordList.Trim.Length > 0 Then
                                'WhereClause += vbCrLf + ChrW(9) + cbThesaurusText + " freetext (SourceImage, '" + ExpandedWordList
                                'WhereClause += vbCrLf + ChrW(9) + cbThesaurusText + " freetext (DataSource.*, '" + ExpandedWordList
                                WhereClause += vbCrLf + ChrW(9) + cbThesaurusText + " freetext ((Description, KeyWords, Notes, SourceImage, SourceName), '" + ExpandedWordList
                                WhereClause += "')" + vbCrLf + "/* 0A2 */ " + vbCrLf
                                rParens += 1
                            End If
                        End If
                    End If
                Else
                    If InputSearchString$.Length > 0 Or txtThesaurus.Trim.Length > 0 Then
                        WhereClause += " (CONTAINS(SourceImage, '"
                        S$ = InputSearchString$
                        WhereClause += buildContainsSyntax(S$, ThesaurusWords)
                        WhereClause += "'))     /*XX03*/ "

                        If txtThesaurus.Trim.Length > 0 Then
                            Dim ExpandedWordList As String = PopulateThesaurusList(ThesaurusList, ThesaurusWords, txtThesaurus, cbThesaurusText)
                            If ExpandedWordList.Trim.Length > 0 Then
                                WhereClause += vbCrLf + ChrW(9) + cbThesaurusText + " CONTAINS (SourceImage, '" + ExpandedWordList
                                WhereClause += "')" + vbCrLf + "/* 0A3 */ " + vbCrLf
                                rParens += 1
                            End If
                        End If
                    End If
                End If
            End If
        Else
            '** No weightings used in this query
            If InputSearchString$.Length = 0 Then
                If gIsAdmin Or gIsGlobalSearcher = True Then
                    ContainsClause$ = " DataSourceOwnerUserID is not null "
                Else
                    ContainsClause$ = " DataSourceOwnerUserID = '" + gCurrUserGuidID + "' "
                End If
            ElseIf useFreetext = True Then
                If InputSearchString$.Length > 0 Or txtThesaurus.Trim.Length > 0 Then

                    'DB.RemoveFreetextStopWords(InputSearchString  )
                    'DB.RemoveFreetextStopWords(txtThesaurus  )
                    Console.WriteLine("FIX THIS 100.100.22")

                    WhereClause += " FREETEXT ((Body, SUBJECT, KeyWords, Description), '"
                    S$ = InputSearchString$
                    WhereClause += buildContainsSyntax(S$, ThesaurusWords)
                    WhereClause += "')" + vbCrLf

                    If txtThesaurus.Trim.Length > 0 Then
                        Dim ExpandedWordList As String = PopulateThesaurusList(ThesaurusList, ThesaurusWords, txtThesaurus, cbThesaurusText)
                        If ExpandedWordList.Trim.Length > 0 Then
                            WhereClause += vbCrLf + ChrW(9) + cbThesaurusText + " FREETEXT ((Body, SUBJECT, KeyWords, Description), '" + ExpandedWordList
                            WhereClause += "')" + vbCrLf + "/* 0A4 */ " + vbCrLf
                            rParens += 1
                        End If
                    End If
                    'WhereClause += ")  /* XX  Final Quotes */"
                End If
            Else
                If InputSearchString$.Length > 0 Or txtThesaurus.Trim.Length > 0 Then
                    WhereClause += " CONTAINS(EMAIL.*, '"
                    S$ = InputSearchString$
                    WhereClause += buildContainsSyntax(S$, ThesaurusWords)
                    WhereClause += "')     /*XX04*/ "

                    If txtThesaurus.Trim.Length > 0 Then
                        Dim ExpandedWordList As String = PopulateThesaurusList(ThesaurusList, ThesaurusWords, txtThesaurus, cbThesaurusText)
                        If ExpandedWordList.Trim.Length > 0 Then
                            WhereClause += vbCrLf + ChrW(9) + cbThesaurusText + " CONTAINS (*, '" + ExpandedWordList
                            WhereClause += "')" + vbCrLf + "/* 0A5 */ " + vbCrLf
                            rParens += 1
                        End If
                    End If
                    'WhereClause += ")" + vbCrLf + "/* 9A */ " + vbCrLf
                End If
            End If
        End If
        ThesaurusList = Nothing
        ThesaurusWords = Nothing
        Return WhereClause$
    End Function
    ''' <summary>
    ''' Gets the next character.
    ''' </summary>
    ''' <param name="S">The s.</param>
    ''' <param name="i">The i.</param>
    ''' <returns>System.String.</returns>
    Function getNextChar(ByVal S As String, ByVal i As Integer) As String
        Dim CH$ = ""


        If S.Trim.Length > (i + 1) Then
            i += 1
            CH = Mid(S, i, 1)
        End If


        Do While CH = " " And i <= S.Length
            i += 1
            If S.Trim.Length < (i + 1) Then
                CH = Mid(S, i, 1)
            End If
        Loop


        Return CH
    End Function
    ''' <summary>
    ''' Cleans the is about search text.
    ''' </summary>
    ''' <param name="SearchText">The search text.</param>
    ''' <returns>System.String.</returns>
    Function CleanIsAboutSearchText(ByVal SearchText As String) As String
        Dim I As Integer = 0
        Dim A As New List(Of String)
        Dim CH As String = ""
        Dim Token = ""
        Dim S As String = ""
        Dim SkipNextToken As Boolean = False
        For I = 1 To SearchText.Trim.Length
REEVAL:
            CH = Mid(SearchText, I, 1)
            If CH.Equals(ChrW(34)) Then
                '** Get the token in quotes
                Dim PreceedingPlusSign As Boolean = False
                Dim PreceedingMinusSign As Boolean = False
                If Token.Equals("+") Or Token.Equals("-") Then
                    PreceedingPlusSign = True
                    Token = ""
                ElseIf Token.Equals("+") Or Token.Equals("-") Then
                    PreceedingMinusSign = True
                    Token = ""
                Else
                    If Token.Length > 0 Then
                        A.Add(Token)
                    End If
                    Token = ""
                End If


                '** go to the next one
                I += 1
                CH = Mid(SearchText, I, 1)
                Token += CH
                Do While CH <> ChrW(34) And I <= SearchText.Length
                    I += 1
                    CH = Mid(SearchText, I, 1)
                    Token += CH
                Loop
                'Token = ChrW(34) + Token
                If PreceedingPlusSign = True Then
                    Token = "+" + ChrW(34) + Token
                    'Dim NextChar$ = getNextChar(SearchText, I)
                    'If NextChar$ = "-" Then
                    '    '** We skip the next token in the stmt
                    'End If
                ElseIf PreceedingMinusSign = True Then
                    Token = "-" + ChrW(34) + Token
                    'Dim NextChar$ = getNextChar(SearchText, I)
                    'If NextChar$ = "+" Then
                    '    '** We skip the next token in the stmt
                    'End If
                Else
                    Token = ChrW(34) + Token
                End If
                A.Add(Token)


                Token = ""
            ElseIf CH.Equals(" ") Or CH = " " Then
                '** Skip the blank spaces
                If Token.Equals("+") Or Token.Equals("-") Then
                    LOG.WriteToSqlLog("Should not be here.")
                Else
                    If Token.Length > 0 Then
                        A.Add(Token)
                    End If
                    Token = ""
                End If


                '** go to the next one
                I += 1
                CH = Mid(SearchText, I, 1)
                Do While CH = " " And I <= SearchText.Length
                    I += 1
                    CH = Mid(SearchText, I, 1)
                Loop
                GoTo REEVAL
            ElseIf CH.Equals(",") Then
                '** Skip the blank spaces
                If Token.Length > 0 Then
                    A.Add(Token)
                End If
                Token = ""
            ElseIf CH.Equals("+") Then
                '** Skip the blank spaces
                Dim NextChar$ = getNextChar(SearchText, I)
                If NextChar$ = "-" Then
                    '** We skip the next token in the stmt
                    SkipNextToken = True
                    A.Add("~")
                End If
                Token += ""
            ElseIf CH.Equals("^") Then
                '** Skip the blank spaces
                Token += ""
            ElseIf CH.Equals("~") Then
                '** Skip the blank spaces
                Token += ""
            ElseIf CH.Equals("(") Or CH.Equals(")") Then
                '** Skip the blank spaces
                Token += ""
            ElseIf CH.Equals("-") Then
                '** Skip the blank spaces
                Dim NextChar$ = getNextChar(SearchText, I)
                If NextChar$ = "+" Then
                    '** We skip the next token in the stmt
                    SkipNextToken = True
                    A.Add("~")
                End If
                Token += ""
            ElseIf CH.Equals("|") Then
                '** Skip the blank spaces
                Token += ""
            Else
                Token += CH
            End If
        Next
        If Token.Length > 0 Then
            A.Add(Token)
        End If
        S = ""
        Dim skipNextWord As Boolean = False
        For I = 0 To A.Count - 1
            Dim tWord$ = A(I)
            tWord$ = UCase(tWord)
            If tWord.Equals("~") Then
                '** we skip the next word period
                skipNextWord = True
            ElseIf tWord.Equals("AND") Then
            ElseIf tWord.Equals("OR") Then
            ElseIf tWord.Equals("NOT") Then
                skipNextWord = True
            ElseIf tWord.Equals("NEAR") Then
            Else
                If skipNextWord Then
                    skipNextWord = False
                Else
                    If I = A.Count - 1 Then
                        S = S + A(I).ToString
                    Else
                        S = S + A(I).ToString + ", "
                    End If
                    If gDebug Then
                        LOG.WriteToSqlLog(S)
                    End If
                End If


            End If
        Next


        Return S


    End Function

    ''' <summary>
    ''' Gens the is about.
    ''' </summary>
    ''' <param name="ckWeighted">if set to <c>true</c> [ck weighted].</param>
    ''' <param name="useFreetext">if set to <c>true</c> [use freetext].</param>
    ''' <param name="SearchText">The search text.</param>
    ''' <param name="isEmailSearch">if set to <c>true</c> [is email search].</param>
    ''' <returns>System.String.</returns>
    Function genIsAbout(ByVal ckWeighted As Boolean, ByVal useFreetext As Boolean, ByVal SearchText As String, ByVal isEmailSearch As Boolean) As String
        If ckWeighted = False Then
            Return ""
        End If
        Dim isAboutClause$ = ""
        Dim SearchStr$ = SearchText
        Dim CorrectedSearchClause As String = CleanIsAboutSearchText(SearchText)
        CorrectedSearchClause = CorrectedSearchClause.Trim
        If CorrectedSearchClause.Length > 2 Then
            Dim C$ = Mid(CorrectedSearchClause, CorrectedSearchClause.Length, 1)
            If C.Equals(",") Then
                CorrectedSearchClause = Mid(CorrectedSearchClause, 1, CorrectedSearchClause.Length - 1)
                CorrectedSearchClause = CorrectedSearchClause.Trim
            End If
        End If
        If isEmailSearch = True Then
            If useFreetext = True Then
                'INNER JOIN FREETEXTTABLE(dataSource, *,
                '    'ISABOUT ("dale miller", "susan miller", jessica )' ) AS KEY_TBL
                '    ON DS.SourceGuid = KEY_TBL.[KEY]
                isAboutClause$ += "INNER JOIN FREETEXTTABLE(EMAIL, *, " + vbCrLf
                isAboutClause$ += "     'ISABOUT ("
                isAboutClause$ += CorrectedSearchClause
                isAboutClause$ += ")' ) as KEY_TBL" + vbCrLf
                isAboutClause$ += "          ON DS.EmailGuid = KEY_TBL.[KEY]" + vbCrLf
            Else
                '    INNER JOIN CONTAINSTABLE(dataSource, *,
                '    'ISABOUT ("dale miller", 
                '"susan miller", jessica )' ) AS KEY_TBL
                '    ON DS.SourceGuid = KEY_TBL.[KEY]
                isAboutClause$ += "INNER JOIN CONTAINSTABLE(EMAIL, *, " + vbCrLf
                isAboutClause$ += "     'ISABOUT ("
                isAboutClause$ += CorrectedSearchClause
                isAboutClause$ += ")' ) as KEY_TBL" + vbCrLf
                isAboutClause$ += "          ON DS.EmailGuid = KEY_TBL.[KEY]" + vbCrLf
            End If
        Else
            If useFreetext = True Then
                'INNER JOIN FREETEXTTABLE(dataSource, *,
                '    'ISABOUT ("dale miller", "susan miller", jessica )' ) AS KEY_TBL
                '    ON DS.SourceGuid = KEY_TBL.[KEY]
                isAboutClause$ += "INNER JOIN FREETEXTTABLE(dataSource, SourceImage, " + vbCrLf
                isAboutClause$ += "     'ISABOUT ("
                isAboutClause$ += CorrectedSearchClause
                isAboutClause$ += ")' ) as KEY_TBL" + vbCrLf
                isAboutClause$ += "          ON DS.SourceGuid = KEY_TBL.[KEY]" + vbCrLf
            Else
                '    INNER JOIN CONTAINSTABLE(dataSource, *,
                '    'ISABOUT ("dale miller", 
                '"susan miller", jessica )' ) AS KEY_TBL
                '    ON DS.SourceGuid = KEY_TBL.[KEY]
                isAboutClause$ += "INNER JOIN CONTAINSTABLE(dataSource, *, " + vbCrLf
                isAboutClause$ += "     'ISABOUT ("
                isAboutClause$ += CorrectedSearchClause
                isAboutClause$ += ")' ) as KEY_TBL" + vbCrLf
                isAboutClause$ += "          ON DS.SourceGuid = KEY_TBL.[KEY]" + vbCrLf
            End If
        End If


        Return isAboutClause


    End Function
    ''' <summary>
    ''' Gets all tables SQL.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getAllTablesSql() As String
        Dim S As String = "Select * from sysobjects where xtype = 'U'"
        Return S
    End Function
    'Public Function getAllColsSql(ByVal TblID as string) As SqlDataReader
    '    Dim S as string = "Select C.name, C.column_id, "
    '    s = s + " C.system_type_id , C.max_length, "
    '    s = s + " C.precision, C.scale, C.is_nullable,"
    '    s = s + " C.is_identity, T.name  "
    '    s = s + " from sys.objects T,  sys.columns C"
    '    s = s + " where T.type = 'U' and"
    '    s = s + " C.object_id = T.object_id and"
    '    s = s + " T.object_id = " + TblID$ + " "
    '    s = s + " order by C.column_id"


    '    Dim rsData As SqlDataReader = Nothing


    '    Try
    '        Dim CS$ = DB.getConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
    '    Catch ex As Exception
    '        LOG.WriteToSqlLog("clsSql : getAllColsSql : 677 : " + ex.Message)
    '    End Try
    '    Return rsData
    'End Function
    ''' <summary>
    ''' Gens the admin content SQL.
    ''' </summary>
    ''' <param name="isAdmin">if set to <c>true</c> [is admin].</param>
    ''' <param name="ckLimitToLib">if set to <c>true</c> [ck limit to library].</param>
    ''' <param name="LibraryName">Name of the library.</param>
    ''' <returns>System.String.</returns>
    Function genAdminContentSql(ByVal isAdmin As Boolean, ByVal ckLimitToLib As Boolean, ByVal LibraryName As String) As String
        Dim UserSql$ = ""
        LibraryName$ = UTIL.RemoveSingleQuotes(LibraryName)
        If gIsAdmin Or gIsGlobalSearcher = True Then
            '** ECM WhereClause
            If ckLimitToLib = True Then
                'UserSql = UserSql + " AND SourceGuid in (SELECT [SourceGuid] FROM [LibraryItems] where LibraryName = '" + LibraryName$ + "')" + vbCrLf
                '** DO NOT PUT vbcrlf at the end of the below lines. That will cause problems in inserting PAGING.
                UserSql = UserSql + " AND SourceGuid in (" + GEN.genLibrarySearch(gCurrUserGuidID, True, LibraryName, "Gen@13") + ")"
            Else
                If gMyContentOnly = True Then
                    UserSql = UserSql + " and ( DataSourceOwnerUserID = '" + gCurrUserGuidID + "') " + vbCrLf
                Else
                    Dim gSearcher As Boolean = False
                    If gIsAdmin Or gIsGlobalSearcher Then
                        gSearcher = True
                    End If
                    Dim IncludeLibsSql As String = GEN.genLibrarySearch(gCurrUserGuidID, True, gSearcher, "@Gen31")
                    UserSql = UserSql + IncludeLibsSql
                End If
                If gMasterContentOnly = True Then
                    UserSql = UserSql + " and ( isMaster = 'Y' )       /*KEEP*/" + vbCrLf
                End If
            End If

            ''** Removed by WDM 7/12/2008
            'UserSql = UserSql + " OR" + vbCrLf
            'UserSql = UserSql + " DataSourceOwnerUserID in (select distinct UserID from LibraryUsers " + vbCrLf
            'UserSql = UserSql + "             where(LibraryName)" + vbCrLf
            'UserSql = UserSql + " in (Select LibraryName from LibrariesContainingUser))" + vbCrLf
            'UserSql = UserSql + " )" + vbCrLf
        Else
            If ckLimitToLib = True Then
                Dim gSearcher As Boolean = False
                If gIsAdmin = True Or gIsGlobalSearcher = True Then
                    gSearcher = True
                End If
                UserSql = " AND SourceGuid in (" + GEN.genLibrarySearch(gCurrUserGuidID, gSearcher, LibraryName, "Gen@01") + ")"

            Else
                'UserSql = UserSql + " and ( DataSourceOwnerUserID is not null OR isPublic = 'Y' )" + vbCrLf
                '** ECM WhereClause
                If gMyContentOnly = True Then
                    UserSql = UserSql + " and ( DataSourceOwnerUserID = '" + gCurrUserGuidID + "') " + vbCrLf
                Else
                    Dim gSearcher As Boolean = False
                    If gIsAdmin = True Or gIsGlobalSearcher = True Then
                        gSearcher = True
                    End If
                    Dim IncludeLibsSql As String = GEN.genLibrarySearch(gCurrUserGuidID, True, gSearcher, "@Gen32")
                    UserSql = UserSql + IncludeLibsSql
                End If

                If gMasterContentOnly = True Then
                    UserSql = UserSql + " and ( isMaster = 'Y' )      /*KEEP*/" + vbCrLf
                End If

            End If

            'UserSql = UserSql + " OR isPublic = 'Y' " + vbCrLf    '** WDM Add 7/9/2009
            '** Removed by WDM 7/12/2008
            'UserSql = UserSql + " OR DataSourceOwnerUserID in (select distinct UserID from LibraryUsers " + vbCrLf
            'UserSql = UserSql + "             where(LibraryName)" + vbCrLf
            'UserSql = UserSql + " in (Select LibraryName from LibrariesContainingUser))" + vbCrLf
            'UserSql = UserSql + " )" + vbCrLf
        End If
        Return UserSql
    End Function
    ''' <summary>
    ''' Gens the admin email SQL.
    ''' </summary>
    ''' <param name="isAdmin">if set to <c>true</c> [is admin].</param>
    ''' <param name="ckLimitToLib">if set to <c>true</c> [ck limit to library].</param>
    ''' <param name="LibraryName">Name of the library.</param>
    ''' <returns>System.String.</returns>
    Function genAdminEmailSql(ByVal isAdmin As Boolean, ByVal ckLimitToLib As Boolean, ByVal LibraryName As String) As String
        Dim UserSql$ = ""
        If gIsAdmin Or gIsGlobalSearcher Then
            '** ECM WhereClause
            If ckLimitToLib = True Then
                '** DO NOT PUT vbcrlf at the end of the below lines. That will cause problems in inserting PAGING.
                Dim gSearcher As Boolean = False
                If gIsAdmin = True Or gIsGlobalSearcher = True Then
                    gSearcher = True
                End If
                UserSql = UserSql + " AND EmailGuid in (" + GEN.genLibrarySearch(gCurrUserGuidID, gSearcher, LibraryName, "Gen@10") + ")"

            Else
                If gMyContentOnly = True Then
                    UserSql = UserSql + " and ( UserID = '" + gCurrUserGuidID + "') " + vbCrLf
                Else
                    Dim gSearcher As Boolean = False
                    If gIsAdmin = True Or gIsGlobalSearcher = True Then
                        gSearcher = True
                    End If
                    Dim IncludeLibsSql As String = GEN.genLibrarySearch(gCurrUserGuidID, False, gSearcher, "@Gen34")
                    UserSql = UserSql + IncludeLibsSql
                End If
                If gMasterContentOnly = True Then
                    UserSql = UserSql + " and ( isMaster = 'Y' )     /*KEEP*/" + vbCrLf
                End If
            End If
            'UserSql = UserSql + " OR" + vbCrLf
            ''UserSql = UserSql + " UserID in (select distinct UserID from LibraryUsers " + vbCrLf
            '** Removed by WDM 7/12/2008
            'UserSql = UserSql + " '" + gCurrUserGuidID + "' in (select distinct UserID from LibraryUsers " + vbCrLf
            'UserSql = UserSql + "             where(LibraryName)" + vbCrLf
            'UserSql = UserSql + " in (Select LibraryName from LibrariesContainingUser))" + vbCrLf
            'UserSql = UserSql + " )" + vbCrLf
        Else
            If ckLimitToLib = True Then
                Dim gSearcher As Boolean = False
                If gIsAdmin = True Or gIsGlobalSearcher = True Then
                    gSearcher = True
                End If
                UserSql = UserSql + " AND EmailGuid in (" + GEN.genLibrarySearch(gCurrUserGuidID, gSearcher, LibraryName, "Gen@11") + ")"
            Else
                '** ECM WhereClause
                If gMyContentOnly = True Then
                    UserSql = UserSql + " and ( UserID = '" + gCurrUserGuidID + "') " + vbCrLf
                Else
                    Dim gSearcher As Boolean = False
                    If gIsAdmin = True Or gIsGlobalSearcher = True Then
                        gSearcher = True
                    End If
                    Dim IncludeLibsSql As String = GEN.genLibrarySearch(gCurrUserGuidID, False, gSearcher, "@Gen30")
                    UserSql = UserSql + IncludeLibsSql
                End If

                If gMasterContentOnly = True Then
                    UserSql = UserSql + " and ( isMaster = 'Y' )      /*KEEP*/" + vbCrLf
                End If

            End If
            ''** Removed by WDM 7/12/2008
            'UserSql = UserSql + " OR isPublic = 'Y' " + vbCrLf
            'UserSql = UserSql + " OR '" + gCurrUserGuidID + "' in (select distinct UserID from LibraryUsers " + vbCrLf
            'UserSql = UserSql + "             where(LibraryName)" + vbCrLf
            'UserSql = UserSql + " in (Select LibraryName from LibrariesContainingUser))" + vbCrLf
            'UserSql = UserSql + " )" + vbCrLf
        End If
        Return UserSql
    End Function
    ''' <summary>
    ''' Gets the content table cols.
    ''' </summary>
    ''' <param name="ckWeighted">if set to <c>true</c> [ck weighted].</param>
    ''' <returns>System.String.</returns>
    Function getContentTblCols(ByVal ckWeighted As Boolean) As String
        Dim DocsSql$ = ""


        If ckWeighted Then
            If gMaxRecordsToFetch.Length > 0 Then
                If Val(gMaxRecordsToFetch) > 0 Then
                    DocsSql = " SELECT TOP " + gMaxRecordsToFetch
                Else
                    DocsSql = " SELECT "
                End If
            End If
            DocsSql += vbTab + " KEY_TBL.RANK, DS.SourceName 	" + vbCrLf
            DocsSql += vbTab + ",DS.CreateDate " + vbCrLf
            DocsSql += vbTab + ",DS.VersionNbr 	" + vbCrLf
            DocsSql += vbTab + ",DS.LastAccessDate " + vbCrLf
            DocsSql += vbTab + ",DS.FileLength " + vbCrLf
            DocsSql += vbTab + ",DS.LastWriteTime " + vbCrLf
            DocsSql += vbTab + ",DS.OriginalFileType 		" + vbCrLf
            DocsSql += vbTab + ",DS.isPublic " + vbCrLf
            DocsSql += vbTab + ",DS.FQN " + vbCrLf
            DocsSql += vbTab + ",DS.SourceGuid " + vbCrLf
            DocsSql += vbTab + ",DS.DataSourceOwnerUserID, DS.FileDirectory, DS.RetentionExpirationDate, DS.isMaster, DS.StructuredData, DS.RepoSvrName " + vbCrLf
            DocsSql += "FROM DataSource as DS " + vbCrLf


        Else
            If gMaxRecordsToFetch.Length > 0 Then
                If Val(gMaxRecordsToFetch) > 0 Then
                    DocsSql = " SELECT TOP " + gMaxRecordsToFetch
                Else
                    DocsSql = " SELECT "
                End If
            End If
            DocsSql += vbTab + "[SourceName] 	" + vbCrLf
            DocsSql += vbTab + ",[CreateDate] " + vbCrLf
            DocsSql += vbTab + ",[VersionNbr] 	" + vbCrLf
            DocsSql += vbTab + ",[LastAccessDate] " + vbCrLf
            DocsSql += vbTab + ",[FileLength] " + vbCrLf
            DocsSql += vbTab + ",[LastWriteTime] " + vbCrLf
            DocsSql += vbTab + ",[SourceTypeCode] 		" + vbCrLf
            DocsSql += vbTab + ",[isPublic] " + vbCrLf
            DocsSql += vbTab + ",[FQN] " + vbCrLf
            DocsSql += vbTab + ",[SourceGuid] " + vbCrLf
            DocsSql += vbTab + ",[DataSourceOwnerUserID], FileDirectory, StructuredData, RepoSvrName " + vbCrLf
            DocsSql += "FROM DataSource " + vbCrLf
        End If


        Return DocsSql
    End Function


    ''' <summary>
    ''' Gets the email table cols main search.
    ''' </summary>
    ''' <param name="ckWeighted">if set to <c>true</c> [ck weighted].</param>
    ''' <param name="ckBusiness">if set to <c>true</c> [ck business].</param>
    ''' <param name="SearchText">The search text.</param>
    ''' <returns>System.String.</returns>
    Function getEmailTblColsMainSearch(ByVal ckWeighted As Boolean, ByVal ckBusiness As Boolean, ByVal SearchText As String) As String
        Dim GenSql$ = ""


        If ckWeighted = True Then
            If gMaxRecordsToFetch.Length > 0 Then
                If Val(gMaxRecordsToFetch) > 0 Then
                    GenSql = " SELECT TOP " + gMaxRecordsToFetch
                Else
                    GenSql = " SELECT "
                End If
            End If
            GenSql = GenSql + "  KEY_TBL.RANK, DS.SentOn " + vbCrLf
            GenSql = GenSql + " ,DS.ShortSubj" + vbCrLf
            GenSql = GenSql + " ,DS.SenderEmailAddress" + vbCrLf
            GenSql = GenSql + " ,DS.SenderName" + vbCrLf
            GenSql = GenSql + " ,DS.SentTO" + vbCrLf
            GenSql = GenSql + " ,substring(DS.Body,1,100) as Body" + vbCrLf
            GenSql = GenSql + " ,DS.CC " + vbCrLf
            GenSql = GenSql + " ,DS.Bcc " + vbCrLf
            GenSql = GenSql + " ,DS.CreationTime" + vbCrLf
            GenSql = GenSql + " ,DS.AllRecipients" + vbCrLf
            GenSql = GenSql + " ,DS.ReceivedByName" + vbCrLf
            GenSql = GenSql + " ,DS.ReceivedTime " + vbCrLf
            GenSql = GenSql + " ,DS.MsgSize" + vbCrLf
            GenSql = GenSql + " ,DS.SUBJECT" + vbCrLf
            GenSql = GenSql + " ,DS.OriginalFolder " + vbCrLf
            GenSql = GenSql + " ,DS.EmailGuid, DS.RetentionExpirationDate, DS.isPublic, DS.ConvertEmlToMSG, DS.UserID, DS.NbrAttachments, DS.SourceTypeCode, 'N' as FoundInAttachment, ' ' as RID, RepoSvrName  " + vbCrLf
            GenSql = GenSql + " FROM EMAIL AS DS " + vbCrLf
            GenSql += genIsAbout(ckWeighted, ckBusiness, SearchText, True)
        Else
            If gMaxRecordsToFetch.Length > 0 Then
                If Val(gMaxRecordsToFetch) > 0 Then
                    GenSql = " SELECT TOP " + gMaxRecordsToFetch
                Else
                    GenSql = " SELECT "
                End If
            End If

            GenSql = GenSql + " [SentOn] " + vbCrLf
            GenSql = GenSql + " ,[ShortSubj]" + vbCrLf
            GenSql = GenSql + " ,[SenderEmailAddress]" + vbCrLf
            GenSql = GenSql + " ,[SenderName]" + vbCrLf
            GenSql = GenSql + " ,[SentTO]" + vbCrLf
            GenSql = GenSql + " ,substring(Body,1,100) as Body " + vbCrLf
            GenSql = GenSql + " ,[CC] " + vbCrLf
            GenSql = GenSql + " ,[Bcc] " + vbCrLf
            GenSql = GenSql + " ,[CreationTime]" + vbCrLf
            GenSql = GenSql + " ,[AllRecipients]" + vbCrLf
            GenSql = GenSql + " ,[ReceivedByName]" + vbCrLf
            GenSql = GenSql + " ,[ReceivedTime] " + vbCrLf
            GenSql = GenSql + " ,[MsgSize]" + vbCrLf
            GenSql = GenSql + " ,[SUBJECT]" + vbCrLf
            GenSql = GenSql + " ,[OriginalFolder] " + vbCrLf
            GenSql = GenSql + " ,[EmailGuid], RetentionExpirationDate, isPublic, ConvertEmlToMSG, UserID, NbrAttachments, SourceTypeCode, 'N' as FoundInAttachment, ' ' as RID, RepoSvrName, 0 as RANK   " + vbCrLf
            GenSql = GenSql + " FROM EMAIL " + vbCrLf
        End If

        GenSql = GenSql + " WHERE " + vbCrLf

        Return GenSql$
    End Function
    ''' <summary>
    ''' Gets the email table cols.
    ''' </summary>
    ''' <param name="ckWeighted">if set to <c>true</c> [ck weighted].</param>
    ''' <param name="ckBusiness">if set to <c>true</c> [ck business].</param>
    ''' <param name="SearchText">The search text.</param>
    ''' <returns>System.String.</returns>
    Function getEmailTblCols(ByVal ckWeighted As Boolean, ByVal ckBusiness As Boolean, ByVal SearchText As String) As String
        Dim SearchSql = ""


        If ckWeighted = True Then
            If gMaxRecordsToFetch.Length > 0 Then
                If Val(gMaxRecordsToFetch) > 0 Then
                    SearchSql = " SELECT TOP " + gMaxRecordsToFetch
                Else
                    SearchSql = " SELECT "
                End If
            End If
            SearchSql = SearchSql + "  KEY_TBL.RANK, DS.SentOn " + vbCrLf
            SearchSql = SearchSql + " ,DS.ShortSubj" + vbCrLf
            SearchSql = SearchSql + " ,DS.SenderEmailAddress" + vbCrLf
            SearchSql = SearchSql + " ,DS.SenderName" + vbCrLf
            SearchSql = SearchSql + " ,DS.SentTO" + vbCrLf
            SearchSql = SearchSql + " ,DS.Body " + vbCrLf
            SearchSql = SearchSql + " ,DS.CC " + vbCrLf
            SearchSql = SearchSql + " ,DS.Bcc " + vbCrLf
            SearchSql = SearchSql + " ,DS.CreationTime" + vbCrLf
            SearchSql = SearchSql + " ,DS.AllRecipients" + vbCrLf
            SearchSql = SearchSql + " ,DS.ReceivedByName" + vbCrLf
            SearchSql = SearchSql + " ,DS.ReceivedTime " + vbCrLf
            SearchSql = SearchSql + " ,DS.MsgSize" + vbCrLf
            SearchSql = SearchSql + " ,DS.SUBJECT" + vbCrLf
            SearchSql = SearchSql + " ,DS.OriginalFolder " + vbCrLf
            SearchSql = SearchSql + " ,DS.EmailGuid, DS.RetentionExpirationDate, DS.isPublic, DS.UserID, DS.SourceTypeCode, DS.NbrAttachments , ' ' as RID, RepoSvrName " + vbCrLf
            SearchSql = SearchSql + " FROM EMAIL AS DS " + vbCrLf
            SearchSql += genIsAbout(ckWeighted, ckBusiness, SearchText, True)
        Else
            If gMaxRecordsToFetch.Length > 0 Then
                If Val(gMaxRecordsToFetch) > 0 Then
                    SearchSql = " SELECT TOP " + gMaxRecordsToFetch
                Else
                    SearchSql = " SELECT "
                End If
            End If
            SearchSql = SearchSql + " [SentOn] " + vbCrLf
            SearchSql = SearchSql + " ,[ShortSubj]" + vbCrLf
            SearchSql = SearchSql + " ,[SenderEmailAddress]" + vbCrLf
            SearchSql = SearchSql + " ,[SenderName]" + vbCrLf
            SearchSql = SearchSql + " ,[SentTO]" + vbCrLf
            SearchSql = SearchSql + " ,[Body] " + vbCrLf
            SearchSql = SearchSql + " ,[CC] " + vbCrLf
            SearchSql = SearchSql + " ,[Bcc] " + vbCrLf
            SearchSql = SearchSql + " ,[CreationTime]" + vbCrLf
            SearchSql = SearchSql + " ,[AllRecipients]" + vbCrLf
            SearchSql = SearchSql + " ,[ReceivedByName]" + vbCrLf
            SearchSql = SearchSql + " ,[ReceivedTime] " + vbCrLf
            SearchSql = SearchSql + " ,[MsgSize]" + vbCrLf
            SearchSql = SearchSql + " ,[SUBJECT]" + vbCrLf
            SearchSql = SearchSql + " ,[OriginalFolder] " + vbCrLf
            SearchSql = SearchSql + " ,[EmailGuid], RetentionExpirationDate, isPublic, UserID, SourceTypeCode, NbrAttachments, ' ' as RID, RepoSvrName, 0 as RANK " + vbCrLf
            SearchSql = SearchSql + " FROM EMAIL " + vbCrLf
        End If
        Return SearchSql
    End Function
    ''' <summary>
    ''' Xgens the header.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Function xgenHeader() As String
        Dim DocsSql$ = "WITH LibrariesContainingUser (LibraryName) AS" + vbCrLf
        DocsSql += " (" + vbCrLf
        DocsSql += "    select LibraryName from LibraryUsers L1 where userid = '" + gCurrUserGuidID + "' " + vbCrLf
        DocsSql += " )" + vbCrLf
        Return DocsSql
    End Function
    ''' <summary>
    ''' Gens the conten count SQL.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Function genContenCountSql() As String
        Dim DocsSql$ = "Select count(*) " + vbCrLf
        DocsSql += "FROM DataSource " + vbCrLf
        Return DocsSql
    End Function
    ''' <summary>
    ''' Gens the email count SQL.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Function genEmailCountSql() As String
        Dim DocsSql$ = "Select count(*) " + vbCrLf
        DocsSql += "FROM [email] " + vbCrLf
        Return DocsSql
    End Function
    ''' <summary>
    ''' Gens the use existing records only.
    ''' </summary>
    ''' <param name="bUseExisting">if set to <c>true</c> [b use existing].</param>
    ''' <param name="GuidColName">Name of the unique identifier col.</param>
    ''' <returns>System.String.</returns>
    Public Function genUseExistingRecordsOnly(ByVal bUseExisting As Boolean, ByVal GuidColName As String) As String
        If bUseExisting = False Then
            Return ""
        End If
        Dim DocsSql$ = " and " + GuidColName$ + " in (SELECT [DocGuid] FROM ActiveSearchGuids where  UserID = '" + gCurrUserGuidID + "')" + vbCrLf
        Return DocsSql
    End Function
    ''' <summary>
    ''' Gens the select email counts.
    ''' </summary>
    ''' <param name="ckWeighted">if set to <c>true</c> [ck weighted].</param>
    ''' <returns>System.String.</returns>
    Function genSelectEmailCounts(ByVal ckWeighted As Boolean) As String
        Dim SearchSql$ = ""
        If ckWeighted = True Then
            SearchSql = SearchSql + " SELECT count(*) "
            'SearchSql = SearchSql + "  KEY_TBL.RANK, DS.SentOn " + vbCrLf
            SearchSql = SearchSql + " FROM EMAIL AS DS " + vbCrLf
        Else
            SearchSql = SearchSql + " SELECT count(*) "
            SearchSql = SearchSql + " FROM EMAIL " + vbCrLf
        End If


        SearchSql = SearchSql + " WHERE " + vbCrLf


        Return SearchSql
    End Function

    ''' <summary>
    ''' Includes the email attachments search.
    ''' </summary>
    ''' <param name="ckIncludeAttachments">if set to <c>true</c> [ck include attachments].</param>
    ''' <param name="ckWeighted">if set to <c>true</c> [ck weighted].</param>
    ''' <param name="ckBusiness">if set to <c>true</c> [ck business].</param>
    ''' <param name="SearchText">The search text.</param>
    ''' <param name="ckLimitToExisting">if set to <c>true</c> [ck limit to existing].</param>
    ''' <param name="txtThesaurus">The text thesaurus.</param>
    ''' <param name="cbThesaurusText">The cb thesaurus text.</param>
    ''' <param name="LibraryName">Name of the library.</param>
    ''' <param name="bIncludeAllLibs">if set to <c>true</c> [b include all libs].</param>
    Sub IncludeEmailAttachmentsSearch(ByVal ckIncludeAttachments As Boolean,
                                      ByVal ckWeighted As Boolean,
                                      ByVal ckBusiness As Boolean,
                                      ByVal SearchText As String,
                                      ByVal ckLimitToExisting As Boolean,
                                      ByVal txtThesaurus As String,
                                      ByVal cbThesaurusText As String,
                                      ByVal LibraryName As String, ByVal bIncludeAllLibs As Boolean)

        If ckIncludeAttachments Then

            If bIncludeAllLibs = True Then
                LibraryName = ""
            End If


            Dim SS As String = "delete FROM [EmailAttachmentSearchList] where [UserID] = '" + gCurrUserGuidID + "'"
            SS = ENC2.AES256EncryptString(SS)
            Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(gSecureID, SS, _UserID, ContractID)
            gLogSQL(BB, ENC2.AES256EncryptString(SS))


            BB = True
            If Not BB Then
                MessageBox.Show("Failed to initialize Attachment Content Search. Content search is not included in the results.")
            Else

                Dim EmailContentWhereClause As String = ""
                Dim insertSql As String = ""

                EmailContentWhereClause = genContainsClause(SearchText, ckBusiness, ckWeighted, True, ckLimitToExisting, ThesaurusList, txtThesaurus, cbThesaurusText, "EMAIL")

                isAdmin = gIsAdmin

                If Not gIsAdmin And gIsGlobalSearcher = False Then
                    EmailContentWhereClause = EmailContentWhereClause + vbCrLf + " And DataSourceOwnerUserID = '" + gCurrUserGuidID + "' "
                Else
                    EmailContentWhereClause = EmailContentWhereClause + vbCrLf + " And DataSourceOwnerUserID IS NOT null "
                End If
                If gDebug Then Console.WriteLine(EmailContentWhereClause)
                insertSql = EmailContentWhereClause

                If ckBusiness Then
                    SearchEmailAttachments(insertSql, True)
                Else
                    SearchEmailAttachments(insertSql, False)
                End If

                If Not gIsAdmin And gIsGlobalSearcher = False Then
                    '** If not an ADMIN, then limit to USER content only
                    insertSql = insertSql + vbCrLf + " AND UserID = '" + gCurrUserGuidID + "' "
                End If


                'AddHandler proxy2.ExecuteSqlNewConnCompleted, AddressOf gLogSQL
                insertSql = ENC2.AES256EncryptString(insertSql)
                BB = proxy2.ExecuteSqlNewConnSecure(gSecureID, insertSql, _UserID, ContractID)
                gLogSQL(BB, ENC2.AES256EncryptString(insertSql))

                BB = True
                If Not BB Then
                    LOG.WriteToSqlLog("clsSQl:IncludeEmailAttachmentsSearch : Failed to insert Attachment Content Search. Content search is not included in the results.")
                    LOG.WriteToSqlLog("clsSQl:IncludeEmailAttachmentsSearch : The SQL Stmt: " + insertSql)
                    NbrOfErrors += 1
                    ''FrmMDIMain.SB.Text = "Errors: " + NbrOfErrors.ToString
                End If


            End If
        End If
    End Sub
    ''' <summary>
    ''' Includes the email attachments search weighted.
    ''' </summary>
    ''' <param name="ckIncludeAttachments">if set to <c>true</c> [ck include attachments].</param>
    ''' <param name="ckWeighted">if set to <c>true</c> [ck weighted].</param>
    ''' <param name="ckBusiness">if set to <c>true</c> [ck business].</param>
    ''' <param name="SearchText">The search text.</param>
    ''' <param name="ckLimitToExisting">if set to <c>true</c> [ck limit to existing].</param>
    ''' <param name="txtThesaurus">The text thesaurus.</param>
    ''' <param name="cbThesaurusText">The cb thesaurus text.</param>
    ''' <param name="MinWeight">The minimum weight.</param>
    Sub IncludeEmailAttachmentsSearchWeighted(ByVal ckIncludeAttachments As Boolean, ByVal ckWeighted As Boolean, ByVal ckBusiness As Boolean, ByVal SearchText As String, ByVal ckLimitToExisting As Boolean, ByVal txtThesaurus As String, ByVal cbThesaurusText As String, ByVal MinWeight As Integer)
        If ckIncludeAttachments Then
            Dim SS As String = "delete FROM [EmailAttachmentSearchList] where [UserID] = '" + gCurrUserGuidID + "'"
            Dim BB As Boolean = True

            'Dim proxy2 As New SVCSearch.Service1Client
            'AddHandler proxy2.ExecuteSqlNewConnCompleted, AddressOf gLogSQL
            SS = ENC2.AES256EncryptString(SS)
            BB = proxy2.ExecuteSqlNewConnSecure(gSecureID, SS, _UserID, ContractID)
            gLogSQL(BB, ENC2.AES256EncryptString(SS))

            If Not BB Then
                MessageBox.Show("Failed to initialize Attachment Content Search. Content search is not included in the results.")
            Else
                Dim EmailContentWhereClause As String = ""
                Dim insertSql As String = ""
                EmailContentWhereClause = genContainsClause(SearchText, ckBusiness, ckWeighted, True, ckLimitToExisting, ThesaurusList, txtThesaurus, cbThesaurusText, "EMAIL")

                Dim SS1 As String = EmailContentWhereClause.Replace("CONTAINS(BODY", "CONTAINS(Attachment")
                Dim SS2 As String = SS1.Replace("CONTAINS(SUBJECT", "CONTAINS(OcrText")
                SS1 = SS2

                insertSql = SS1
                If ckBusiness Then
                    GetSubContainsClauseWeighted(SearchText, insertSql, True, MinWeight)
                Else
                    GetSubContainsClauseWeighted(SearchText, insertSql, False, MinWeight)
                End If

                insertSql = ENC2.AES256EncryptString(insertSql)
                BB = proxy2.ExecuteSqlNewConnSecure(gSecureID, insertSql, _UserID, ContractID)
                gLogSQL(BB, ENC2.AES256EncryptString(insertSql))


                BB = True
                If Not BB Then
                    LOG.WriteToSqlLog("clsSQl:IncludeEmailAttachmentsSearch : Failed to insert Attachment Content Search. Content search is not included in the results.")
                    LOG.WriteToSqlLog("clsSQl:IncludeEmailAttachmentsSearch : The SQL Stmt: " + insertSql)
                    NbrOfErrors += 1
                    ''FrmMDIMain.SB.Text = "Errors: " + NbrOfErrors.ToString
                End If
            End If
        End If
    End Sub




    ''' <summary>
    ''' Gets the sub contains clause weighted.
    ''' </summary>
    ''' <param name="SearchText">The search text.</param>
    ''' <param name="ContainsClause">The contains clause.</param>
    ''' <param name="isFreetext">if set to <c>true</c> [is freetext].</param>
    ''' <param name="MinWeight">The minimum weight.</param>
    Sub GetSubContainsClauseWeighted(ByVal SearchText As String, ByRef ContainsClause As String, ByVal isFreetext As Boolean, ByVal MinWeight As Integer)
        Dim S As String = ""

        Dim I As Integer = 0

        Try
            Dim CorrectedSearchClause As String = CleanIsAboutSearchText(SearchText)
            CorrectedSearchClause = CorrectedSearchClause.Trim
            If CorrectedSearchClause.Length > 2 Then
                Dim C$ = Mid(CorrectedSearchClause, CorrectedSearchClause.Length, 1)
                If C.Equals(",") Then
                    CorrectedSearchClause = Mid(CorrectedSearchClause, 1, CorrectedSearchClause.Length - 1)
                    CorrectedSearchClause = CorrectedSearchClause.Trim
                End If
            End If

            'CorrectedSearchClause = UTIL.RemoveOcrProblemChars(CorrectedSearchClause as string)

            S = "insert EmailAttachmentSearchList ([EmailGuid], [UserID], Weight, RowID) " + vbCrLf

            S = S + "   SELECT [EmailGuid] ,[UserID], KEY_TBL.RANK, RowID " + vbCrLf
            S = S + "   FROM EmailAttachment " + vbCrLf
            S = S + "      INNER JOIN CONTAINSTABLE(EmailAttachment,attachment, 'ISABOUT (" + CorrectedSearchClause + ")' ) as KEY_TBL" + vbCrLf
            S = S + "        ON rowid = KEY_TBL.[KEY]" + vbCrLf
            S = S + "   WHERE " + vbCrLf

            If isFreetext = False Then
                ContainsClause$ = ContainsClause$ + " and ((UserID is not null) and UserID = '" + gCurrUserGuidID + "' and KEY_TBL.RANK > " + MinWeight.ToString + " or isPublic = 'Y')"
                ContainsClause$ = S + ContainsClause$ + vbCrLf
                Return
            End If

            S$ = ContainsClause$
            I = 0
            I = InStr(S, "(")
            'Mid(ContainsClause, I, 1) = " "
            MidX(ContainsClause, I, " ")
            S = S.Trim
            I = InStr(S, ",")
            S = Mid(S, I)
            I = InStr(S, "/*")
            If I > 0 Then
                S = Mid(S, 1, I - 1)
            End If
            If isFreetext Then
                S = "FREETEXT ((Attachment, OcrText)" + S
            Else
                S = ContainsClause$
            End If

            ContainsClause$ = S + S + vbCrLf

        Catch ex As Exception
            Console.WriteLine(ex.Message)
        End Try
    End Sub

    ''' <summary>
    ''' Parses the search string.
    ''' </summary>
    ''' <param name="A">a.</param>
    ''' <param name="S">The s.</param>
    Sub ParseSearchString(ByRef A As List(Of String), ByVal S As String)
        Dim I As Integer = 0
        Dim J As Integer = 0
        Dim K As Integer = S.Trim.Length
        Dim S1$ = ""
        Dim S2$ = ""
        Dim CH$ = ""
        Dim Token = ""

        S$ = S$.Trim

        For I = 1 To K
reeval:
            CH = Mid(S, I, 1)
            Select Case CH
                Case ChrW(34)
                    Token += CH
                    I += 1
                    CH = Mid(S, I, 1)
                    Do While CH <> ChrW(34) And I <= K
                        Token += CH
                        I += 1
                        CH = Mid(S, I, 1)
                    Loop
                    Token += CH
                    A.Add(Token.Trim)
                    Token = ""

                Case "+"
                    If Token.Trim.Length > 0 Then
                        A.Add(Token.Trim)
                        Token = ""
                    End If
                    A.Add(CH)
                    Token = ""
                Case "|"
                    If Token.Trim.Length > 0 Then
                        A.Add(Token.Trim)
                        Token = ""
                    End If
                    A.Add(" ")
                    Token = ""
                Case "("
                    If Token.Trim.Length > 0 Then
                        A.Add(Token.Trim)
                        Token = ""
                    End If
                    A.Add(CH)
                    Token = ""
                Case ")"
                    If Token.Trim.Length > 0 Then
                        A.Add(Token.Trim)
                        Token = ""
                    End If
                    A.Add(CH)
                    Token = ""
                Case "-"
                    If Token.Trim.Length > 0 Then
                        A.Add(Token.Trim)
                        Token = ""
                    End If
                    A.Add(CH)
                    Token = ""
                Case "~"
                    If Token.Trim.Length > 0 Then
                        A.Add(Token.Trim)
                        Token = ""
                    End If
                    A.Add(CH)
                    Token = ""
                Case "^"
                    If Token.Trim.Length > 0 Then
                        A.Add(Token.Trim)
                        Token = ""
                    End If
                    A.Add(CH)
                    Token = ""
                Case " "
                    If Token.Trim.Length > 0 Then
                        A.Add(Token.Trim)
                        Token = ""
                    End If
                    I += 1
                    CH = Mid(S, I, 1)
                    Do While CH = " " And I <= K
                        Token += CH
                        I += 1
                        CH = Mid(S, I, 1)
                    Loop
                    GoTo reeval
                Case Else
                    Token += CH
            End Select
        Next
        If Token.Trim.Length > 0 Then
            A.Add(Token.Trim)
        End If

        Dim T1$ = ""
        Dim P1$ = ""

        For I = 0 To A.Count - 1
            If gDebug Then Console.WriteLine(A(I))
            T1 = A(I)
            If P1.Equals("-") And T1.Equals("+") Then
                A(I - 1) = "+" And A(I) = "-"
            End If
            If P1.Equals("NOT") And T1.Equals("AND") Then
                A(I - 1) = "AND" And A(I) = "NOT"
            End If
            If P1.Equals("-") And T1.Equals("AND") Then
                A(I - 1) = "AND" And A(I) = "NOT"
            End If
            If P1.Equals("NOT") And T1.Equals("+") Then
                A(I - 1) = "AND" And A(I) = "NOT"
            End If
            P1 = T1
        Next
    End Sub
    ''' <summary>
    ''' Rebuilds the string.
    ''' </summary>
    ''' <param name="A">a.</param>
    ''' <param name="S">The s.</param>
    Sub RebuildString(ByVal A As List(Of String), ByRef S As String)

        Dim I As Integer = 0
        Dim J As Integer = 0

        Dim S1$ = ""
        Dim S2$ = ""
        Dim CH$ = ""
        Dim Token = ""
        Dim PrevToken$ = ""
        Dim PrevSymbol$ = ""
        Dim CurrSymbol$ = ""
        Dim CurrSymbolIsKeyWord As Boolean = False
        Dim PrevSymbolIsKeyWord As Boolean = False
        Dim OrMayBeNeeded As Boolean = False

        S = ""

        For I = 0 To A.Count - 1
            If gDebug Then Console.WriteLine(A(I))
            Token = A(I)
            Select Case UCase(Token)
                Case "OR"
                    CurrSymbol$ = "|"
                    Token = "OR"
                    CurrSymbolIsKeyWord = True
                Case "+"
                    CurrSymbol$ = "+"
                    Token = "AND"
                    CurrSymbolIsKeyWord = True
                Case "AND"
                    CurrSymbol$ = "+"
                    Token = "AND"
                    CurrSymbolIsKeyWord = True
                Case "NEAR"
                    CurrSymbol$ = "+"
                    Token = "NEAR"
                    CurrSymbolIsKeyWord = True
                Case "("
                    CurrSymbol$ = ""
                    Token = "("
                    CurrSymbolIsKeyWord = True
                Case ")"
                    CurrSymbol$ = ""
                    Token = ")"
                    CurrSymbolIsKeyWord = True
                Case "-"
                    CurrSymbol$ = "-"
                    Token = "NOT"
                    CurrSymbolIsKeyWord = True
                Case "NOT"
                    CurrSymbol$ = "-"
                    Token = "NOT"
                    CurrSymbolIsKeyWord = True
                Case "~"
                    CurrSymbol$ = "~"
                    Token = "~"
                    CurrSymbolIsKeyWord = True
                Case "^"
                    CurrSymbol$ = "^"
                    Token = "^"
                    CurrSymbolIsKeyWord = True
                Case ChrW(254)
                    CurrSymbol$ = ChrW(254)
                    Token = ""
                    OrMayBeNeeded = True
                Case Else
                    CurrSymbol$ = ""
                    CurrSymbol$ = ""
                    Token = A(I)
                    CurrSymbolIsKeyWord = False
            End Select
            If PrevSymbol = ")" And CurrSymbol = "^" Then
                '** Skip this line
                S = S + " OR "
                GoTo ProcessNextToken
            End If
            If PrevSymbol = ")" And CurrSymbol = "~" Then
                '** Skip this line
                S = S + " OR "
                GoTo ProcessNextToken
            End If
            If OrMayBeNeeded And CurrSymbolIsKeyWord = False Then
                S = S + " oR "
            End If
            If OrMayBeNeeded And CurrSymbolIsKeyWord = True Then
                OrMayBeNeeded = False
            End If
            If PrevSymbol = ChrW(254) And CurrSymbol = ChrW(254) Then
                '** Skip this line
                GoTo ProcessNextToken
            End If
            If PrevSymbol = ChrW(254) And CurrSymbolIsKeyWord Then
                S = S.Trim + " " + Token
                GoTo ProcessNextToken
            End If
            If PrevSymbol = ChrW(254) And CurrSymbolIsKeyWord = False Then
                S = S + " Or " + Token

            End If
            If PrevSymbol = ChrW(254) And CurrSymbolIsKeyWord = False Then
                S = S + " Or " + Token

            End If
            If PrevSymbol.Equals("~") And CurrSymbolIsKeyWord = False Then
                S = S + Token
                GoTo ProcessNextToken
            End If
            If PrevSymbol.Equals("^") And CurrSymbolIsKeyWord = False Then
                S = S + Token
                GoTo ProcessNextToken
            End If
            If CurrSymbolIsKeyWord = True And CurrSymbol = ChrW(254) Then
                '** Skip this line
                GoTo ProcessNextToken
            End If
            If PrevSymbolIsKeyWord = False And CurrSymbolIsKeyWord = False And I > 0 Then
                '** do nothing 
                S = S + " or " + Token
                GoTo ProcessNextToken
            End If
            If PrevSymbolIsKeyWord = False And CurrSymbolIsKeyWord = False And I = 0 Then
                '** do nothing 
                S = Token + " "
                GoTo ProcessNextToken
            End If
            If PrevSymbolIsKeyWord = True And CurrSymbolIsKeyWord = False Then
                S = S.Trim + " " + Token
            End If
            If PrevSymbolIsKeyWord = False And CurrSymbolIsKeyWord = True Then
                S = S.Trim + " " + Token
            End If
            If PrevSymbolIsKeyWord = True And CurrSymbolIsKeyWord = True Then
                If PrevSymbol = "NOT" And CurrSymbol = "OR" Then
                    S = S + ""
                ElseIf PrevSymbol = "OR" And CurrSymbol = "NOT" Then
                    S = S + ""
                Else
                    S = S.Trim + " " + Token
                End If
            End If
ProcessNextToken:
            PrevToken = Token
            PrevSymbol = CurrSymbol
            PrevSymbolIsKeyWord = CurrSymbolIsKeyWord
            If gDebug Then Console.WriteLine(S)
        Next

        S$ = S$.Trim
    End Sub
    ''' <summary>
    ''' Counts the double quotes.
    ''' </summary>
    ''' <param name="S">The s.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function CountDoubleQuotes(ByVal S As String) As Boolean
        S$ = S$.Trim
        If S.Trim.Length = 0 Then
            Return True
        End If
        Dim I As Integer = 0
        Dim CH$ = ""
        Dim iCnt As Integer = 0
        If InStr(1, S, ChrW(34)) = 0 Then
            Return True
        End If
        For I = 1 To S.Trim.Length
            CH = Mid(S, I, 1)
            If CH.Equals(ChrW(34)) Then
                iCnt += 1
            End If
        Next
        If iCnt Mod 2 = 0 Then
            Return True
        Else
            Return False
        End If
    End Function
    ''' <summary>
    ''' Pres the process search.
    ''' </summary>
    ''' <param name="S">The s.</param>
    ''' <param name="bFullTextSearch">if set to <c>true</c> [b full text search].</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function PreProcessSearch(ByRef S As String, ByVal bFullTextSearch As Boolean) As Boolean
        'S = S.Trim        
        Dim B As Boolean = True
        Try
            Dim I As Integer = 0
            Dim S1 As String = ""
            Dim S2 As String = ""
            Dim CH As String = ""
            Dim aList As New List(Of String)
            Dim K As Integer = K

            ParseSearchString(aList, S)
            RebuildString(aList, S)

reeval:
            K = S.Trim.Length
            Dim NewStr$ = ""

            For I = 1 To K
                Dim CurrChar$ = Mid(S, I, 1)
EvalCurrChar:
                Dim PrevChar$ = ""
                If I > 1 Then
                    PrevChar$ = Mid(S, I - 1, 1)
                Else
                End If
                If CurrChar.Equals(ChrW(34)) Then
                    NewStr$ += CurrChar
                    I += 1
                    CurrChar$ = Mid(S, I, 1)
                    Do While CurrChar$ <> ChrW(34) And I <= S.Trim.Length
                        NewStr$ += CurrChar
                        I += 1
                        CurrChar$ = Mid(S, I, 1)
                    Loop
                    NewStr$ += CurrChar
                    GoTo GetNextChar
                End If
                If CurrChar.Equals(" ") Then
                    NewStr$ += CurrChar
                    I += 1
                    CurrChar$ = Mid(S, I, 1)
                    Do While CurrChar$.Equals(" ") And I <= S.Trim.Length
                        NewStr$ += ChrW(254)
                        I += 1
                        CurrChar$ = Mid(S, I, 1)
                    Loop
                    If CurrChar.Equals(")") Then
                        If gDebug Then Console.WriteLine("Here xxx1")
                    End If
                    GoTo EvalCurrChar
                End If
                If CurrChar.Equals("-") Or CurrChar.Equals("+") Or CurrChar.Equals("|") Or CurrChar.Equals("^") Or CurrChar.Equals("~") Or CurrChar.Equals("(") Then
                    NewStr$ += CurrChar
                    I += 1
                    CurrChar$ = Mid(S, I, 1)
                    Do While CurrChar$.Equals(" ") And I <= S.Trim.Length
                        NewStr$ += ChrW(254)
                        I += 1
                        CurrChar$ = Mid(S, I, 1)
                    Loop
                    GoTo EvalCurrChar
                End If

                If CurrChar.Equals("+") And PrevChar.Equals("-") Then
                    'Mid(S, I, 1) = "-"
                    MidX(S, I, "-")
                    'Mid(S, I - 1, 1) = "+"
                    MidX(S, I - 1, "+")
                End If
                If CurrChar.Equals("+") And PrevChar.Equals("+") Then
                    GoTo GetNextChar
                End If
                If CurrChar.Equals("-") And PrevChar.Equals("-") Then
                    GoTo GetNextChar
                End If
                If CurrChar.Equals("^") And PrevChar.Equals("^") Then
                    GoTo GetNextChar
                End If
                If CurrChar.Equals("~") And PrevChar.Equals("~") Then
                    GoTo GetNextChar
                End If
                If CurrChar.Equals(")") And (PrevChar.Equals(" ") Or PrevChar.Equals(ChrW(254))) Then
                    Dim C$ = ""
                    Dim II As Integer = NewStr.Length
                    C = Mid(S, II, 1)
                    Do While (C.Equals(" ") Or C.Equals(ChrW(254))) And II > 0
                        'Mid(NewStr, II, 1) = ChrW(254)
                        MidX(NewStr, II, ChrW(254))
                        II = II - 1
                        C = Mid(NewStr, II, 1)
                    Loop
                    'GoTo EvalCurrChar
                    C = ""
                End If


                NewStr$ += CurrChar
GetNextChar:
            Next
            NewStr = DMA.RemoveChar(NewStr, ChrW(254))
            S = NewStr
        Catch ex As Exception
            B = False
        End Try

        Return B

    End Function
    ''' <summary>
    ''' Validates the not clauses.
    ''' </summary>
    ''' <param name="SqlText">The SQL text.</param>
    Public Sub ValidateNotClauses(ByRef SqlText As String)
        If SqlText.Trim.Length = 0 Then
            Return
        End If


        Dim DoThis As Boolean = False


        If Not DoThis Then
            Return
        End If


        Dim I As Integer = 0
        Dim prevWord As String = ""
        Dim currWord As String = ""
        Dim CH As String = ""
        Dim aList As New List(Of String)
        For I = 1 To SqlText.Length
            CH = Mid(SqlText, I, 1)
            If CH = ChrW(34) Then
                I = I + 1
                CH = Mid(SqlText, I, 1)
                Do While CH <> ChrW(34) And I <= SqlText.Length
                    I = I + 1
                    CH = Mid(SqlText, I, 1)
                Loop
            ElseIf CH = " " Then
                'Mid(SqlText, I, 1) = ChrW(254)
                MidX(SqlText, I, ChrW(254))
            End If
        Next
        Dim A$() = SqlText.Split(ChrW(254))
        currWord = ""
        prevWord = ""
        For I = 0 To UBound(A)
            currWord = A(I)
            If UCase(currWord).Equals("NOT") And UCase(prevWord).Equals("AND") Then
                aList.Add(currWord)
            ElseIf UCase(currWord).Equals("OR") And UCase(prevWord).Equals("OR") Then
                '** DO nothing - user supplied multiple blanks
            ElseIf UCase(currWord).Equals("AND") And UCase(prevWord).Equals("OR") Then
                '** DO nothing - user supplied multiple blanks
            ElseIf UCase(currWord).Equals("OR") And UCase(prevWord).Equals("AND") Then
                aList.Add(currWord)
            ElseIf UCase(currWord).Equals("NOT") And UCase(prevWord).Equals("IS") Then
                aList.Add(currWord)
            ElseIf UCase(currWord).Equals("NOT") And Not UCase(prevWord).Equals("AND") Then
                currWord = "And Not"
                aList.Add(currWord)
            ElseIf UCase(currWord).Equals("FORMSOF") And Not UCase(prevWord).Equals("AND") Then
                currWord = "FormsOF"
                aList.Add(currWord)
            Else
                aList.Add(currWord)
            End If
            prevWord = currWord
        Next
        SqlText$ = ""
        For I = 0 To aList.Count - 1
            Try
                'If aList(I) = Nothing Then
                '    LOG.WriteToSqlLog("nothing")
                '    Dim X# = 1
                'Else
                Dim tWord$ = aList(I)
                Dim EOL$ = ""
                Select Case LCase(tWord)
                    Case "select"
                        EOL = vbCrLf
                    Case "from"
                        EOL = vbCrLf
                    Case "where"
                        EOL = vbCrLf
                    Case "order"
                        EOL = vbCrLf
                    Case "and"
                        EOL = vbCrLf
                    Case "or"
                        EOL = vbCrLf
                End Select
                If InStr(tWord, ",") > 0 Then
                    EOL = vbCrLf + vbTab
                End If
                If InStr(tWord, "not", CompareMethod.Text) > 0 Then
                    Dim x# = 1
                End If
                If I = 0 Then
                    SqlText += EOL + aList(0).Trim
                Else
                    SqlText += " " + EOL + aList(I).Trim
                End If
                'End If
            Catch ex As Exception
                LOG.WriteToSqlLog(ex.Message)
            End Try
        Next
    End Sub
    ''' <summary>
    ''' Gens the is in libraries SQL.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function genIsInLibrariesSql() As Boolean

        Dim B As Boolean = False
        Dim S As String = ""
        S = S + " delete from TempUserLibItems where UserID = '" + gCurrUserGuidID + "'"
        Try
            'B = DB.ExecuteSqlNewConn(S)
            'Dim proxy As New SVCSearch.Service1Client

            S = ENC2.AES256EncryptString(S)
            Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(gSecureID, S, _UserID, ContractID)
            gLogSQL(BB, ENC2.AES256EncryptString(S))

        Catch ex As Exception
            B = False
            LOG.WriteToSqlLog("ERROR genIsInLibrariesSql: " + ex.Message + vbCrLf + S)
        End Try

        Return B

    End Function

    ''' <summary>
    ''' Gens all libraries SQL.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Function genAllLibrariesSql() As String

        Dim S As String = ""
        S = S + " select distinct SourceGuid, '" + gCurrUserGuidID + "' from LibraryItems" + vbCrLf
        S = S + "  where LibraryName in (" + vbCrLf
        S = S + "  select distinct LibraryName from GroupLibraryAccess " + vbCrLf
        S = S + "  where GroupName in "
        S = S + "  (select distinct GroupName from GroupUsers where UserID = 'wmiller')" + vbCrLf
        S = S + "  union " + vbCrLf
        S = S + "  select distinct LibraryName from LibraryUsers where UserID = 'wmiller' )" + vbCrLf

        Return S

    End Function

    ''' <summary>
    ''' Adds the paging.
    ''' </summary>
    ''' <param name="StartPageNo">The start page no.</param>
    ''' <param name="EndPageNo">The end page no.</param>
    ''' <param name="SqlQuery">The SQL query.</param>
    ''' <param name="bIncludeLibraryFilesInSearch">if set to <c>true</c> [b include library files in search].</param>
    Sub AddPaging(ByVal StartPageNo As Integer, ByVal EndPageNo As Integer, ByRef SqlQuery As String, ByVal bIncludeLibraryFilesInSearch As Boolean)

        Dim WeightedSearch As Boolean = False
        Dim L As New List(Of String)

        Dim A$() = SqlQuery.Split(vbCrLf)
        Dim S As String = SqlQuery
        Dim xContentAdded As Boolean = False
        Dim ContainsUnion As Boolean = False
        Dim ContainsLimitToLibrary As Boolean = False

        Dim iSelect As Integer = 0

        For i As Integer = 0 To UBound(A)
            S = A(i).Trim
            If gClipBoardActive = True Then Console.WriteLine(S)
            If InStr(S, "SELECT   distinct  LibraryItems.SourceGuid") > 0 Then
                Console.WriteLine("XXX1 Here")
            End If
            If InStr(S, "LibraryUsers") > 0 Then
                Console.WriteLine("XXX1 Here")
            End If
            If InStr(S, "FROM TempUserLibItems", CompareMethod.Text) > 0 Then
                Console.WriteLine("Here 22,22,1")
            End If
            If InStr(S, "UNION", CompareMethod.Text) > 0 Then
                ContainsUnion = True
            End If

            If InStr(S, "/*") > 0 And InStr(S, "*/") > 0 Then
                L.Add(ChrW(9) + S + vbCrLf)
                GoTo NEXTLINE
            End If

            If InStr(S, "EmailAttachmentSearchList", CompareMethod.Text) > 0 Then
                'Console.WriteLine("Here xx0011")
                L.Add(ChrW(9) + S + vbCrLf)
                GoTo NEXTLINE
            End If
            'SELECT TOP 1000  KEY_TBL.RANK
            If InStr(S, "SELECT", CompareMethod.Text) > 0 And InStr(S, "KEY_TBL.RANK", CompareMethod.Text) > 0 Then
                WeightedSearch = True
                'Else
                '    WeightedSearch = False
            End If
            If InStr(S, "ORDER BY KEY_TBL.RANK DESC", CompareMethod.Text) > 0 Then
                WeightedSearch = True
                S = ChrW(9) + "/* " + S + " */" + vbCrLf + ChrW(9) + "/* above commented out by Pagination Module */"
            End If
            If InStr(S, "/*KEPP*/", CompareMethod.Text) > 0 Then
                ContainsLimitToLibrary = True
            Else
                ContainsLimitToLibrary = False
            End If
            If ContainsLimitToLibrary = True Then
                S = ChrW(9) + S
                L.Add(ChrW(9) + S + vbCrLf)
            ElseIf ContainsUnion = False And InStr(S, "select", CompareMethod.Text) > 0 _
                And InStr(S, "*", CompareMethod.Text) = 0 _
                And InStr(S, "FROM [LibraryItems]", CompareMethod.Text) = 0 _
                And InStr(S, "FROM TempUserLibItems", CompareMethod.Text) = 0 _
                Then
                If S.Length >= "select".Length Then
                    If InStr(S, "or EmailGuid in (SELECT   distinct  LibraryItems.SourceGuid", CompareMethod.Text) > 0 Then
                        L.Add(S + vbCrLf)
                        Console.WriteLine("XX2 Do nothing here.")
                    ElseIf InStr(S, "or SourceGuid in (SELECT   distinct  LibraryItems.SourceGuid", CompareMethod.Text) > 0 Then
                        L.Add(S + vbCrLf)
                        Console.WriteLine("XX3 Do nothing here.")
                    ElseIf Mid(S, 1, 6).ToUpper.Equals("SELECT") Then
                        L.Add("WITH xContent AS" + vbCrLf)
                        L.Add("(" + vbCrLf)
                        L.Add(S + vbCrLf)
                        xContentAdded = False
                    End If
                End If
            ElseIf InStr(S, "FROM datasource", CompareMethod.Text) > 0 Or InStr(S, "FROM DataSource", CompareMethod.Text) > 0 Then
                If WeightedSearch = True Then
                    L.Add(ChrW(9) + ",ROW_NUMBER() OVER (ORDER BY Rank DESC) AS ROWID" + vbCrLf)
                Else
                    L.Add(ChrW(9) + ",ROW_NUMBER() OVER (ORDER BY SourceName ASC) AS ROWID" + vbCrLf)
                End If

                L.Add(S + vbCrLf)
            ElseIf InStr(S, "FROM EMAIL", CompareMethod.Text) > 0 Then
                If WeightedSearch = True Then
                    L.Add(ChrW(9) + ",ROW_NUMBER() OVER (ORDER BY Rank DESC) AS ROWID" + vbCrLf)
                Else
                    L.Add(ChrW(9) + ",ROW_NUMBER() OVER (ORDER BY SentOn ASC) AS ROWID" + vbCrLf)
                End If

                L.Add(S + vbCrLf)
            ElseIf ContainsUnion = False And InStr(ChrW(9) + S, "order by", CompareMethod.Text) > 0 Then
                'If WeightedSearch = False Then
                S = "--" + S
                'End If

                L.Add(S + vbCrLf)
                L.Add(")" + vbCrLf)
                L.Add("Select * " + vbCrLf)
                L.Add("FROM xContent" + vbCrLf)
                L.Add("WHERE ROWID BETWEEN " + StartPageNo.ToString + " AND " + EndPageNo.ToString + vbCrLf)
                WeightedSearch = False
                xContentAdded = True
            ElseIf ContainsUnion = True And InStr(ChrW(9) + S, "order by [SourceName]", CompareMethod.Text) > 0 Then
                'If WeightedSearch = False Then
                S = "--" + S
            Else
                L.Add(ChrW(9) + S + vbCrLf)
            End If
NEXTLINE:
        Next
        If xContentAdded = False Then
            L.Add(")" + vbCrLf)
            L.Add("Select * " + vbCrLf)
            L.Add("FROM xContent" + vbCrLf)
            L.Add("WHERE ROWID BETWEEN " + StartPageNo.ToString + " AND " + EndPageNo.ToString + vbCrLf)
        End If
        '** Rebuild the statement
        Dim II As Integer = 0
        SqlQuery = ""
        For Each S In L
            II += 1
            If gClipBoardActive Then Console.WriteLine(II.ToString + ": " + S)
            If InStr(S, vbCrLf) = 0 Then
                S = S + vbCrLf
            End If
            SqlQuery += S
        Next

    End Sub

    ''' <summary>
    ''' Gens the attachment search SQL admin.
    ''' </summary>
    ''' <param name="EmailContainsClause">The email contains clause.</param>
    ''' <returns>System.String.</returns>
    Function genAttachmentSearchSQLAdmin(ByVal EmailContainsClause As String) As String

        Dim S = ""

        S += " select EmailGuid from EmailAttachment where " + EmailContainsClause

        Return S
    End Function

    ''' <summary>
    ''' Gens the attachment search SQL user.
    ''' </summary>
    ''' <param name="EmailContainsClause">The email contains clause.</param>
    ''' <returns>System.String.</returns>
    Function genAttachmentSearchSQLUser(ByVal EmailContainsClause As String) As String

        Dim S = ""

        S += " select EmailGuid from EmailAttachment where " + EmailContainsClause + vbCrLf + " and UserID = '" + gCurrUserGuidID + "'"

        Return S
    End Function

    ''' <summary>
    ''' Gens all libraries select.
    ''' </summary>
    ''' <param name="EmailContainsClause">The email contains clause.</param>
    ''' <returns>System.String.</returns>
    Function genAllLibrariesSelect(ByVal EmailContainsClause As String) As String

        Dim AllLibSql$ = ""

        AllLibSql += " SELECT distinct SourceGuid FROM [LibraryItems] where LibraryName in " + vbCrLf
        AllLibSql += " (" + vbCrLf
        AllLibSql += " select distinct LibraryName from LibraryUsers where UserID = '" + gCurrUserGuidID + "'" + vbCrLf
        AllLibSql += " )" + vbCrLf


        Dim S As String = ""
        S = S + " and EmailGuid in (" + AllLibSql + ")"

        Return S
    End Function
    ''' <summary>
    ''' Gens the single library select.
    ''' </summary>
    ''' <param name="EmailContainsClause">The email contains clause.</param>
    ''' <param name="LibraryName">Name of the library.</param>
    ''' <returns>System.String.</returns>
    Function genSingleLibrarySelect(ByVal EmailContainsClause As String, ByVal LibraryName As String) As String
        Dim S As String = ""

        'S = S + " and EmailGuid in (SELECT [SourceGuid] FROM [LibraryItems] where LibraryName = '" + LibraryName$ + "')"
        '** DO NOT PUT vbcrlf at the end of the below lines. That will cause problems in inserting PAGING.
        Dim gSearcher As Boolean = False
        If gIsAdmin = True Or gIsGlobalSearcher = True Then
            gSearcher = True
        End If

        S = S + " AND EmailGuid in (" + GEN.genLibrarySearch(gCurrUserGuidID, gSearcher, LibraryName, "Gen@12") + ")"

        Return S
    End Function

    ''' <summary>
    ''' Searches the email attachments.
    ''' </summary>
    ''' <param name="ContainsClause">The contains clause.</param>
    ''' <param name="isFreetext">if set to <c>true</c> [is freetext].</param>
    Sub SearchEmailAttachments(ByRef ContainsClause As String, ByVal isFreetext As Boolean)

        Dim tSql$ = ""
        Dim S As String = ""
        Dim I As Integer = 0

        S = "delete from EmailAttachmentSearchList where UserID = '" + gCurrUserGuidID + "' "
        bRunningSql = True
        'Dim proxy As New SVCSearch.Service1Client
        S = ENC2.AES256EncryptString(S)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(gSecureID, S, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(S))


        Try

            tSql$ = "insert EmailAttachmentSearchList ([UserID],[EmailGuid], RowID) " + vbCrLf
            tSql$ = tSql$ + " select '" + gCurrUserGuidID + "',[EmailGuid], RowID  " + vbCrLf
            tSql$ = tSql$ + "FROM EmailAttachment " + vbCrLf
            tSql$ = tSql$ + "where " + vbCrLf
            S$ = ContainsClause$
            I = 0
            I = InStr(S, "(")
            'Mid(ContainsClause, I, 1) = " "
            MidX(ContainsClause, I, " ")
            S = S.Trim
            I = InStr(S, ",")
            S = Mid(S, I)
            I = InStr(S, "/*")
            If I > 0 Then
                S = Mid(S, 1, I - 1)
            End If
            If isFreetext Then
                S = "FREETEXT ((Body, SUBJECT, KeyWords, Description)" + S
            Else
                S = "contains(EmailAttachment.*" + S
            End If

            ContainsClause$ = tSql$ + S + vbCrLf
        Catch ex As Exception
            Console.WriteLine(ex.Message)
        End Try

        'Clipboard.Clear()
        'Clipboard.SetText(ContainsClause as string)

    End Sub

    ''' <summary>
    ''' Clients the execute SQL new conn2.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="SS">The ss.</param>
    Sub client_ExecuteSqlNewConn2(RC As Boolean, SS As String)
        If RC Then
            Dim S As String = ""
            S = ""
            S = S + " INSERT INTO TempUserLibItems (SourceGuid, Userid)" + vbCrLf
            S = S + " select distinct SourceGuid, '" + gCurrUserGuidID + "' from LibraryItems" + vbCrLf
            S = S + " where LibraryName in (" + vbCrLf
            S = S + " select distinct LibraryName from GroupLibraryAccess " + vbCrLf
            S = S + " where GroupName in " + vbCrLf
            S = S + " (select distinct GroupName from GroupUsers where UserID = '" + gCurrUserGuidID + "')" + vbCrLf
            S = S + " union " + vbCrLf
            S = S + " select distinct LibraryName from LibraryUsers where UserID = '" + gCurrUserGuidID + "'"
            S = S + " )" + vbCrLf

            'Dim proxy As New SVCSearch.Service1Client
            S = ENC2.AES256EncryptString(S)
            Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(gSecureID, S, _UserID, ContractID)
            gLogSQL(BB, ENC2.AES256EncryptString(S))
        Else
            gErrorCount += 1
            LOG.WriteToSqlLog("ERROR clsSql 100: " + SS)
        End If
    End Sub
    ''' <summary>
    ''' Allows an object to try to free resources and perform other cleanup operations before it is reclaimed by garbage collection.
    ''' </summary>
    Protected Overrides Sub Finalize()
        Try
        Finally
            MyBase.Finalize()      'define the destructor
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try
    End Sub

    ''' <summary>
    ''' Sets the xx search SVC end point.
    ''' </summary>
    Private Sub setXXSearchSvcEndPoint()

        If (SearchEndPoint.Length = 0) Then
            Return
        End If

        Dim ServiceUri As New Uri(SearchEndPoint)
        Dim EPA As New System.ServiceModel.EndpointAddress(ServiceUri)

        ProxySearch.Endpoint.Address = EPA
        proxy2.Endpoint.Address = EPA
        proxy3.Endpoint.Address = EPA
        GC.Collect()
        GC.WaitForPendingFinalizers()
    End Sub

End Class
