Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO


Public Class clsSqlSVR
    'Dim DB As New clsDatabase
    Dim DMA As New clsDmaSVR
    'Dim GEN As New clsGeneratorSVR

    Dim UTIL As New clsUtilitySVR
    Dim LOG As New clsLogging

    'Dim TREX As New clsDb

    Dim dDeBug As Boolean = True
    Dim bSaveToClipBoard As Boolean = True

    Dim txtSearch$ = Nothing
    Dim getCountOnly As Boolean = Nothing
    Dim UseExistingRecordsOnly As Boolean = Nothing
    Dim ckWeighted As Boolean = Nothing

    Dim DBisAdmin As Boolean = Nothing
    Dim ckBusiness As Boolean = Nothing
    Dim isInflectionalTerm As Boolean = False
    Dim InflectionalToken As Boolean = False


    Property pInflectionalToken() As String
        Get
            Return InflectionalToken
        End Get
        Set(ByVal tVal As String)
            InflectionalToken = tVal
        End Set
    End Property
    Property bInflectionalTerm() As Boolean
        Get
            Return isInflectionalTerm
        End Get
        Set(ByVal tVal As Boolean)
            isInflectionalTerm = tVal
        End Set
    End Property




    'Property pGeneratedSQL() As String
    '    Get
    '        Return GeneratedSQL
    '    End Get
    '    Set(ByVal tVal As String)
    '        GeneratedSQL = tVal
    '    End Set
    'End Property
    Property pCkBusiness() As Boolean
        Get
            Return ckBusiness
        End Get
        Set(ByVal tVal As Boolean)
            ckBusiness = tVal
        End Set
    End Property
    Property pIsAdmin() As Boolean
        Get
            Return DBisAdmin
        End Get
        Set(ByVal tVal As Boolean)
            DBisAdmin = tVal
        End Set
    End Property
    Property pCkWeighted() As Boolean
        Get
            Return ckWeighted
        End Get
        Set(ByVal tVal As Boolean)
            ckWeighted = tVal
        End Set
    End Property
    Property pUseExistingRecordsOnly() As Boolean
        Get
            Return UseExistingRecordsOnly
        End Get
        Set(ByVal tVal As Boolean)
            UseExistingRecordsOnly = tVal
        End Set
    End Property
    Property pGetCountOnly() As Boolean
        Get
            Return getCountOnly
        End Get
        Set(ByVal tVal As Boolean)
            getCountOnly = tVal
        End Set
    End Property
    Property pTxtSearch() As String
        Get
            Return txtSearch$
        End Get
        Set(ByVal tVal As String)
            txtSearch$ = tVal
        End Set
    End Property




    Sub SkipToNextToken(ByVal S as string, byref I As Integer)
        Dim Delimiters As String = " ,:+-^|"
        S = S.Trim
        Dim Token as string = ""
        Dim CH as string = ""
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
            Debug.Print(Token)
            If I > S.Length Then
                Exit Do
            End If
        Loop


    End Sub


    Sub GetToken(ByVal I As Integer, ByRef k As Integer, ByVal tStr as string)
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

    Sub TranslateDelimiter(ByVal CH as string, byref Translateddel as string)
        Translateddel = ""
        Select Case CH
            Case "+"
                Translateddel$ = "And"
            Case "-"
                Translateddel$ = "Not"
            Case "|"
                Translateddel$ = "Or"
        End Select
    End Sub












    Public Function getAllTablesSql() As String
        Dim s$ = "Select * from sysobjects where xtype = 'U'"
        Return s
    End Function







    'Function getEmailTblColsMainSearch(ByVal ckWeighted As Boolean, ByVal ckBusiness As Boolean, ByVal SearchText as string) As String
    '    Dim GenSql as string = ""


    '    If ckWeighted = True Then
    '        If gMaxRecordsToFetch.Length > 0 Then
    '            If Val(gMaxRecordsToFetch) > 0 Then
    '                GenSql = " SELECT TOP " + gMaxRecordsToFetch
    '            Else
    '                GenSql = " SELECT "
    '            End If
    '        End If
    '        GenSql = GenSql + "  KEY_TBL.RANK, DS.SentOn " + vbCrLf
    '        GenSql = GenSql + " ,DS.ShortSubj" + vbCrLf
    '        GenSql = GenSql + " ,DS.SenderEmailAddress" + vbCrLf
    '        GenSql = GenSql + " ,DS.SenderName" + vbCrLf
    '        GenSql = GenSql + " ,DS.SentTO" + vbCrLf
    '        GenSql = GenSql + " ,substring(DS.Body,1,100) as Body" + vbCrLf
    '        GenSql = GenSql + " ,DS.CC " + vbCrLf
    '        GenSql = GenSql + " ,DS.Bcc " + vbCrLf
    '        GenSql = GenSql + " ,DS.CreationTime" + vbCrLf
    '        GenSql = GenSql + " ,DS.AllRecipients" + vbCrLf
    '        GenSql = GenSql + " ,DS.ReceivedByName" + vbCrLf
    '        GenSql = GenSql + " ,DS.ReceivedTime " + vbCrLf
    '        GenSql = GenSql + " ,DS.MsgSize" + vbCrLf
    '        GenSql = GenSql + " ,DS.SUBJECT" + vbCrLf
    '        GenSql = GenSql + " ,DS.OriginalFolder " + vbCrLf
    '        GenSql = GenSql + " ,DS.EmailGuid, DS.RetentionExpirationDate, DS.isPublic, DS.ConvertEmlToMSG, DS.UserID, DS.NbrAttachments, DS.SourceTypeCode, 'N' as FoundInAttachment, ' ' as RID, RepoSvrName  " + vbCrLf
    '        GenSql = GenSql + " FROM EMAIL AS DS " + vbCrLf
    '        GenSql += genIsAbout(ckWeighted, ckBusiness, SearchText, True)
    '    Else
    '        If gMaxRecordsToFetch.Length > 0 Then
    '            If Val(gMaxRecordsToFetch) > 0 Then
    '                GenSql = " SELECT TOP " + gMaxRecordsToFetch
    '            Else
    '                GenSql = " SELECT "
    '            End If
    '        End If

    '        GenSql = GenSql + " [SentOn] " + vbCrLf
    '        GenSql = GenSql + " ,[ShortSubj]" + vbCrLf
    '        GenSql = GenSql + " ,[SenderEmailAddress]" + vbCrLf
    '        GenSql = GenSql + " ,[SenderName]" + vbCrLf
    '        GenSql = GenSql + " ,[SentTO]" + vbCrLf
    '        GenSql = GenSql + " ,substring(Body,1,100) as Body " + vbCrLf
    '        GenSql = GenSql + " ,[CC] " + vbCrLf
    '        GenSql = GenSql + " ,[Bcc] " + vbCrLf
    '        GenSql = GenSql + " ,[CreationTime]" + vbCrLf
    '        GenSql = GenSql + " ,[AllRecipients]" + vbCrLf
    '        GenSql = GenSql + " ,[ReceivedByName]" + vbCrLf
    '        GenSql = GenSql + " ,[ReceivedTime] " + vbCrLf
    '        GenSql = GenSql + " ,[MsgSize]" + vbCrLf
    '        GenSql = GenSql + " ,[SUBJECT]" + vbCrLf
    '        GenSql = GenSql + " ,[OriginalFolder] " + vbCrLf
    '        GenSql = GenSql + " ,[EmailGuid], RetentionExpirationDate, isPublic, ConvertEmlToMSG, UserID, NbrAttachments, SourceTypeCode, 'N' as FoundInAttachment, ' ' as RID, RepoSvrName   " + vbCrLf
    '        GenSql = GenSql + " FROM EMAIL " + vbCrLf
    '    End If

    '    GenSql = GenSql + " WHERE " + vbCrLf

    '    Return GenSql$
    'End Function

    Function xgenHeader() As String
        Dim DocsSql$ = "WITH LibrariesContainingUser (LibraryName) AS" + vbCrLf
        DocsSql += " (" + vbCrLf
        DocsSql += "    select LibraryName from LibraryUsers L1 where userid = '" + gCurrUserGuidID + "' " + vbCrLf
        DocsSql += " )" + vbCrLf
        Return DocsSql
    End Function


    Function genSelectEmailCounts(ByVal ckWeighted As Boolean) As String
        Dim SearchSql as string = ""
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









    Sub ParseSearchString(ByRef A As ArrayList, ByVal S as string)
        Dim I As Integer = 0
        Dim J As Integer = 0
        Dim K As Integer = S.Trim.Length
        Dim S1 as string = ""
        Dim S2 as string = ""
        Dim CH as string = ""
        Dim Token as string = ""

        S$ = S$.Trim

        For I = 1 To K
reeval:
            CH = Mid(S, I, 1)
            Select Case CH
                Case Chr(34)
                    Token += CH
                    I += 1
                    CH = Mid(S, I, 1)
                    Do While CH <> Chr(34) And I <= K
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

        Dim T1 as string = ""
        Dim P1 as string = ""

        For I = 0 To A.Count - 1
            If dDeBug Then Console.WriteLine(A(I))
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
    Sub RebuildString(ByVal A As ArrayList, ByRef S as string)

        Dim I As Integer = 0
        Dim J As Integer = 0

        Dim S1 as string = ""
        Dim S2 as string = ""
        Dim CH as string = ""
        Dim Token as string = ""
        Dim PrevToken as string = ""
        Dim PrevSymbol as string = ""
        Dim CurrSymbol as string = ""
        Dim CurrSymbolIsKeyWord As Boolean = False
        Dim PrevSymbolIsKeyWord As Boolean = False
        Dim OrMayBeNeeded As Boolean = False

        S = ""

        For I = 0 To A.Count - 1
            If dDeBug Then Console.WriteLine(A(I))
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
                    CurrSymbol = ""
                    Token = "("
                    CurrSymbolIsKeyWord = True
                Case ")"
                    CurrSymbol = ""
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
                Case Chr(254)
                    CurrSymbol$ = Chr(254)
                    Token = ""
                    OrMayBeNeeded = True
                Case Else
                    CurrSymbol = ""
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
            If PrevSymbol = Chr(254) And CurrSymbol = Chr(254) Then
                '** Skip this line
                GoTo ProcessNextToken
            End If
            If PrevSymbol = Chr(254) And CurrSymbolIsKeyWord Then
                S = S.Trim + " " + Token
                GoTo ProcessNextToken
            End If
            If PrevSymbol = Chr(254) And CurrSymbolIsKeyWord = False Then
                S = S + " Or " + Token

            End If
            If PrevSymbol = Chr(254) And CurrSymbolIsKeyWord = False Then
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
            If CurrSymbolIsKeyWord = True And CurrSymbol = Chr(254) Then
                '** Skip this line
                GoTo ProcessNextToken
            End If
            If PrevSymbolIsKeyWord = False And CurrSymbolIsKeyWord = False And I > 0 Then
                '** do nothing 
                S = S + " or " + Token  'WDM 6/19/2011 Looking into changing this
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
            If dDeBug Then Console.WriteLine(S)
        Next

        S$ = S$.Trim
    End Sub
    Public Function CountDoubleQuotes(ByVal S as string) As Boolean
        S$ = S$.Trim
        If S.Trim.Length = 0 Then
            Return True
        End If
        Dim I As Integer = 0
        Dim CH as string = ""
        Dim iCnt As Integer = 0
        If InStr(1, S, Chr(34)) = 0 Then
            Return True
        End If
        For I = 1 To S.Trim.Length
            CH = Mid(S, I, 1)
            If CH.Equals(Chr(34)) Then
                iCnt += 1
            End If
        Next
        If iCnt Mod 2 = 0 Then
            Return True
        Else
            Return False
        End If
    End Function

    Public Function PreProcessSearch(ByRef S As String, ByVal bFullTextSearch As Boolean) As Boolean
        'S = S.Trim        
        Dim B As Boolean = True
        Try
            Dim I As Integer = 0
            Dim S1 As String = ""
            Dim S2 As String = ""
            Dim CH As String = ""
            Dim aList As New ArrayList
            Dim K As Integer = K

            ParseSearchString(aList, S)
            RebuildString(aList, S)

reeval:
            K = S.Trim.Length
            Dim NewStr as string = ""

            For I = 1 To K
                Dim CurrChar$ = Mid(S, I, 1)
EvalCurrChar:
                Dim PrevChar as string = ""
                If I > 1 Then
                    PrevChar$ = Mid(S, I - 1, 1)
                Else
                End If
                If CurrChar.Equals(Chr(34)) Then
                    NewStr$ += CurrChar
                    I += 1
                    CurrChar$ = Mid(S, I, 1)
                    Do While CurrChar$ <> Chr(34) And I <= S.Trim.Length
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
                        NewStr$ += Chr(254)
                        I += 1
                        CurrChar$ = Mid(S, I, 1)
                    Loop
                    If CurrChar.Equals(")") Then
                        If dDeBug Then Console.WriteLine("Here xxx1")
                    End If
                    GoTo EvalCurrChar
                End If
                If CurrChar.Equals("-") Or CurrChar.Equals("+") Or CurrChar.Equals("|") Or CurrChar.Equals("^") Or CurrChar.Equals("~") Or CurrChar.Equals("(") Then
                    NewStr$ += CurrChar
                    I += 1
                    CurrChar$ = Mid(S, I, 1)
                    Do While CurrChar$.Equals(" ") And I <= S.Trim.Length
                        NewStr$ += Chr(254)
                        I += 1
                        CurrChar$ = Mid(S, I, 1)
                    Loop
                    GoTo EvalCurrChar
                End If

                If CurrChar.Equals("+") And PrevChar.Equals("-") Then
                    Mid(S, I, 1) = "-"
                    Mid(S, I - 1, 1) = "+"
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
                If CurrChar.Equals(")") And (PrevChar.Equals(" ") Or PrevChar.Equals(Chr(254))) Then
                    Dim C as string = ""
                    Dim II As Integer = NewStr.Length
                    C = Mid(S, II, 1)
                    Do While (C.Equals(" ") Or C.Equals(Chr(254))) And II > 0
                        Mid(NewStr, II, 1) = Chr(254)
                        II = II - 1
                        C = Mid(NewStr, II, 1)
                    Loop
                    'GoTo EvalCurrChar
                    C = ""
                End If


                NewStr$ += CurrChar
GetNextChar:
            Next
            NewStr = DMA.RemoveChar(NewStr, Chr(254))
            S = NewStr
        Catch ex As Exception
            B = False
        End Try

        Return B

    End Function



    Function genAllLibrariesSql() As String

        Dim S as string = ""
        S = S + " select distinct SourceGuid, '" + gCurrUserGuidID + "' from LibraryItems" + vbCrLf
        S = S + "  where LibraryName in (" + vbCrLf
        S = S + "  select distinct LibraryName from GroupLibraryAccess " + vbCrLf
        S = S + "  where GroupName in "
        S = S + "  (select distinct GroupName from GroupUsers where UserID = 'wmiller')" + vbCrLf
        S = S + "  union " + vbCrLf
        S = S + "  select distinct LibraryName from LibraryUsers where UserID = 'wmiller' )" + vbCrLf
        Return S

    End Function

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
                L.Add(Chr(9) + S + vbCrLf)
                GoTo NEXTLINE
            End If

            If InStr(S, "EmailAttachmentSearchList", CompareMethod.Text) > 0 Then
                'Console.WriteLine("Here xx0011")
                L.Add(Chr(9) + S + vbCrLf)
                GoTo NEXTLINE
            End If
            'SELECT TOP 1000  KEY_TBL.RANK
            If InStr(S, "SELECT", CompareMethod.Text) > 0 And InStr(S, "KEY_TBL.RANK", CompareMethod.Text) > 0 Then
                WeightedSearch = True
                'Else
                '    WeightedSearch = false
            End If
            If InStr(S, "ORDER BY KEY_TBL.RANK DESC", CompareMethod.Text) > 0 Then
                WeightedSearch = True
                S = Chr(9) + "/* " + S + " */" + vbCrLf + Chr(9) + "/* above commented out by Pagination Module */"
            End If
            If InStr(S, "/*KEPP*/", CompareMethod.Text) > 0 Then
                ContainsLimitToLibrary = True
            Else
                ContainsLimitToLibrary = False
            End If
            If ContainsLimitToLibrary = True Then
                S = Chr(9) + S
                L.Add(Chr(9) + S + vbCrLf)
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
                    L.Add(Chr(9) + ",ROW_NUMBER() OVER (ORDER BY Rank DESC) AS ROWID" + vbCrLf)
                Else
                    L.Add(Chr(9) + ",ROW_NUMBER() OVER (ORDER BY SourceName ASC) AS ROWID" + vbCrLf)
                End If

                L.Add(S + vbCrLf)
            ElseIf InStr(S, "FROM EMAIL", CompareMethod.Text) > 0 Then
                If WeightedSearch = True Then
                    L.Add(Chr(9) + ",ROW_NUMBER() OVER (ORDER BY Rank DESC) AS ROWID" + vbCrLf)
                Else
                    L.Add(Chr(9) + ",ROW_NUMBER() OVER (ORDER BY SentOn ASC) AS ROWID" + vbCrLf)
                End If

                L.Add(S + vbCrLf)
            ElseIf ContainsUnion = False And InStr(Chr(9) + S, "order by", CompareMethod.Text) > 0 Then
                'If WeightedSearch = false Then
                S = "--" + S
                'End If

                L.Add(S + vbCrLf)
                L.Add(")" + vbCrLf)
                L.Add("Select * " + vbCrLf)
                L.Add("FROM xContent" + vbCrLf)
                L.Add("WHERE ROWID BETWEEN " + StartPageNo.ToString + " AND " + EndPageNo.ToString + vbCrLf)
                WeightedSearch = False
                xContentAdded = True
            ElseIf ContainsUnion = True And InStr(Chr(9) + S, "order by [SourceName]", CompareMethod.Text) > 0 Then
                'If WeightedSearch = false Then
                S = "--" + S
            Else
                L.Add(Chr(9) + S + vbCrLf)
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

    Function genAttachmentSearchSQLAdmin(ByVal EmailContainsClause As String) As String

        Dim S = ""

        S += " select EmailGuid from EmailAttachment where " + EmailContainsClause

        Return S
    End Function

    Function genAttachmentSearchSQLUser(ByVal EmailContainsClause As String) As String

        Dim S = ""

        S += " select EmailGuid from EmailAttachment where " + EmailContainsClause + vbCrLf + " and UserID = '" + gCurrUserGuidID + "'"

        Return S
    End Function

    Function genAllLibrariesSelect(ByVal EmailContainsClause As String) As String

        Dim AllLibSql as string = ""

        AllLibSql += " SELECT distinct SourceGuid FROM [LibraryItems] where LibraryName in " + vbCrLf
        AllLibSql += " (" + vbCrLf
        AllLibSql += " select distinct LibraryName from LibraryUsers where UserID = '" + gCurrUserGuidID + "'" + vbCrLf
        AllLibSql += " )" + vbCrLf


        Dim S as string = ""
        S = S + " and EmailGuid in (" + AllLibSql + ")"

        Return S
    End Function




End Class
