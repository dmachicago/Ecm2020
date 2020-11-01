Imports System.IO
'Imports System.Data.Sql
'Imports System.Data.SqlClient

Public Class clsGeneratorSVR

    'Inherits clsDatabaseSVR

    Dim UTIL As New clsUtilitySVR
    Dim DMA As New clsDmaSVR

    Dim ThesaurusList As New ArrayList

    Public TopRows As Integer = 0
    Public UseWeights As Boolean = False
    Private SortOrder As String = ""

    Dim getCountOnly As Boolean = Nothing
    Dim UseExistingRecordsOnly As Boolean = Nothing

    Dim dDebug As Boolean = False

    '** Fix this one to include all PARAMETERIZED search statements

    Function genDocPagingByRowHeader() As String

        Dim S As String = " WITH xContent AS (" + vbCrLf
        Return S

    End Function

    Function genDocPagingByRowFooter(ByVal StartNbr As Integer, ByVal EndNbr As Integer) As String

        Dim S As String = ""
        S = S + " )" + vbCrLf
        S = S + " SELECT * FROM xContent" + vbCrLf
        S = S + " WHERE ROWID BETWEEN " + StartNbr.ToString + " AND " + EndNbr.ToString + vbCrLf
        Return S

    End Function

    Function DocSearchMetaData(ByVal MetaDataName As String, ByVal MetaDataValue As String, ByVal Mandatory As Boolean) As String

        If MetaDataValue.Length = 0 Then
            Return String.Empty
        ElseIf MetaDataName.Length = 0 Then
            Return String.Empty
        End If

        MetaDataValue$ = FixSingleQuote(MetaDataValue)

        Dim S As String = ""
        Dim CH As String = ""
        Dim WhereClause As String = ""
        'Dim MetaDataType$ = getAttributeDataType(MetaDataName  )
        'Dim QuotesNeeded As Boolean = QuotesRequired(MetaDataType  )

        If Mandatory Then
            S = S + " and SourceGuid in "
            S = S + " ("
            S = S + " Select D.SourceGuid"
            S = S + " FROM DataSource AS D INNER JOIN"
            S = S + " SourceAttribute AS S ON D.SourceGuid = S.SourceGuid"
            S = S + " WHERE (S.AttributeName = '" + MetaDataName + "' and AttributeValue like '" + MetaDataValue + "')"
            S = S + " )"
        Else
            S = S + " OR SourceGuid in "
            S = S + " ("
            S = S + " Select D.SourceGuid"
            S = S + " FROM DataSource AS D INNER JOIN"
            S = S + " SourceAttribute AS S ON D.SourceGuid = S.SourceGuid"
            S = S + " WHERE (S.AttributeName = '" + MetaDataName + "' and AttributeValue like '" + MetaDataValue + "')"
            S = S + " )"
        End If

        Return S

    End Function

    Function DocSearchCreatedWithinLastXDays(ByVal ckLimitTodays As Boolean, ByVal DaysOld As String, ByVal Mandatory As Boolean) As String
        Dim S As String = ""
        If ckLimitTodays Then
            If Mandatory Then
                S = " AND (LastWriteTime >= GETDATE() - " + DaysOld + " OR CreateDate >= GETDATE() - " + DaysOld.ToString + ")" + vbCrLf
            Else
                S = " OR (LastWriteTime >= GETDATE() - " + DaysOld + " OR CreateDate >= GETDATE() - " + DaysOld.ToString + ")" + vbCrLf
            End If
        End If
        Return S
    End Function

    Function DocSearchLimitToCurrentGuids(ByVal CurrUserID As String, ByVal ckLimitToExisting As Boolean, ByVal CurrentGuids As List(Of String)) As String
        Dim S As String = ""
        If ckLimitToExisting Then
            'LimitToExistingRecs(CurrentGuids)
            S = " AND (SourceGuid in (SELECT [DocGuid] FROM ActiveSearchGuids where UserID = '" + CurrUserID + "'))"
        End If
        Return S
    End Function

    Function DocSearchCreateDate(ByVal ckDate As Boolean, _
                           ByVal DATECODE As String, _
                           ByVal Mandatory As Boolean, _
                           ByVal bReceived As Boolean, _
                           ByVal bCreated As Boolean, _
                           ByVal Startdate As Date, _
                           ByVal EndDate As Date) As String

        If Not ckDate Then
            Return String.Empty
        End If

        Dim S As String = String.Empty

        Select Case DATECODE
            Case "AFTER"
                If Mandatory = True Then
                    S += " AND "
                Else
                    S += " OR "
                End If
                S += " (CreateDate > '" + CDate(Startdate).ToString + "')" + vbCrLf
            Case "BEFORE"
                If Mandatory = True Then
                    S += " AND "
                Else
                    S += " OR "
                End If
                S += " (CreateDate < '" + CDate(Startdate).ToString + "')" + vbCrLf
            Case "BETWEEN"
                If Mandatory = True Then
                    S += " AND "
                Else
                    S += " OR "
                End If
                S += " (CreateDate >= '" + CDate(Startdate).ToString + "' AND CreateDate <= '" + CDate(EndDate).ToString + "')" + vbCrLf
            Case "NOT BETWEEN"
                If Mandatory = True Then
                    S += " AND "
                Else
                    S += " OR "
                End If
                S += " (CreateDate <= '" + CDate(Startdate).ToString + "' AND CreateDate >= '" + CDate(EndDate).ToString + "')" + vbCrLf
            Case "ON"
                If Mandatory = True Then
                    S += " AND "
                Else
                    S += " OR "
                End If
                S += " (CreateDate = '" + CDate(Startdate).ToString + "')" + vbCrLf
            Case Else
                S = String.Empty
        End Select

        Return S

    End Function

    Function DocSearchDateLastWriteTime(ByVal ckDate As Boolean, _
                           ByVal DATECODE As String, _
                           ByVal Mandatory As Boolean, _
                           ByVal bReceived As Boolean, _
                           ByVal bCreated As Boolean, _
                           ByVal Startdate As Date, _
                           ByVal EndDate As Date) As String

        If Not ckDate Then
            Return String.Empty
        End If

        Dim S As String = String.Empty

        Select Case DATECODE
            Case "AFTER"
                If Mandatory = True Then
                    S += " AND "
                Else
                    S += " OR "
                End If
                S += " (LastWriteTime > '" + CDate(Startdate).ToString + "')" + vbCrLf
            Case "BEFORE"
                If Mandatory = True Then
                    S += " AND "
                Else
                    S += " OR "
                End If
                S += " (LastWriteTime < '" + CDate(Startdate).ToString + "')" + vbCrLf
            Case "BETWEEN"
                If Mandatory = True Then
                    S += " AND "
                Else
                    S += " OR "
                End If
                S += " (LastWriteTime >= '" + CDate(Startdate).ToString + "' AND LastWriteTime <= '" + CDate(EndDate).ToString + "')" + vbCrLf
            Case "NOT BETWEEN"
                If Mandatory = True Then
                    S += " AND "
                Else
                    S += " OR "
                End If
                S += " (LastWriteTime <= '" + CDate(Startdate).ToString + "' AND LastWriteTime >= '" + CDate(EndDate).ToString + "')" + vbCrLf
            Case "ON"
                If Mandatory = True Then
                    S += " AND "
                Else
                    S += " OR "
                End If
                S += " (LastWriteTime = '" + CDate(Startdate).ToString + "')" + vbCrLf
            Case Else
                S = String.Empty
        End Select

        Return S

    End Function

    Function DocSearchFileDirectory(ByVal FileDirectory As String, ByVal Mandatory As Boolean) As String

        If FileDirectory.Trim.Length = 0 Then
            Return String.Empty
        End If
        FileDirectory = FixSingleQuote(FileDirectory)
        Dim S As String = String.Empty
        If Mandatory Then
            S += " AND (FileDirectory like '" + FileDirectory + "' )"
        Else
            S += " OR (FileDirectory like '" + FileDirectory + "' )"
        End If
        Return S

    End Function

    Function SearchByMinWeight(ByVal MinWeight As String, ByVal SetWeight As Boolean) As String

        If SetWeight = False Then
            Return String.Empty
        End If

        Dim S As String = String.Empty
        S += " and KEY_TBL.RANK >= " + MinWeight + vbCrLf

        Return S
    End Function

    Function DocSearchByFileExt(ByVal EXT As String, ByVal Mandatory As Boolean) As String
        If EXT.Trim.Length = 0 Then
            Return String.Empty
        End If
        EXT = FixSingleQuote(EXT)
        Dim S As String = String.Empty
        If Mandatory Then
            S += " AND (OriginalFileType like '" + EXT + "' )"
        Else
            S += " OR (OriginalFileType like '" + EXT + "' )"
        End If

        Return S
    End Function

    Function DocSearchByFileName(ByVal FQN As String, ByVal Mandatory As Boolean) As String
        If FQN.Trim.Length = 0 Then
            Return String.Empty
        End If
        FQN = FixSingleQuote(FQN)
        Dim S As String = String.Empty
        If Mandatory Then
            S += " AND (SourceName like '" + FQN + "' )"
        Else
            S += " OR (SourceName like '" + FQN + "' )"
        End If
        Return S
    End Function

    Function DocSearchOrderByWeights() As String
        Dim S As String = String.Empty
        S = " and KEY_TBL.RANK >= 0 ORDER BY KEY_TBL.RANK DESC "
        Return S
    End Function

    Function DocSearchGenCols(ByVal ckWeighted As Boolean, ByVal searchCriteria As String) As String

        Dim ckBusiness As Boolean = False
        Dim S As String = ""

        If ckWeighted = True Then
            S = S + "Select " + vbCrLf
            S += vbTab + " KEY_TBL.RANK, DS.SourceName 	" + vbCrLf
            S += vbTab + ",DS.CreateDate " + vbCrLf
            S += vbTab + ",DS.VersionNbr 	" + vbCrLf
            S += vbTab + ",DS.LastAccessDate " + vbCrLf
            S += vbTab + ",DS.FileLength " + vbCrLf
            S += vbTab + ",DS.LastWriteTime " + vbCrLf
            S += vbTab + ",DS.OriginalFileType 		" + vbCrLf
            S += vbTab + ",DS.isPublic " + vbCrLf
            S += vbTab + ",DS.FQN " + vbCrLf
            S += vbTab + ",DS.SourceGuid " + vbCrLf
            S += vbTab + ",DS.DataSourceOwnerUserID, DS.FileDirectory, DS.RetentionExpirationDate, DS.isMaster, DS.StructuredData, DS.RepoSvrName, DS.Description, DS.RssLinkFlg, DS.isWebPage " + vbCrLf
            S += "FROM DataSource as DS " + vbCrLf

            Dim JoinStr As String = genInnerJoin("C", "XXXX")
            JoinStr = "/* " + JoinStr + " 0001 */"
            S += JoinStr
            S += genIsAbout(ckWeighted, ckBusiness, searchCriteria.Trim, False)

            'If bSaveToClipBoard Then
            'Clipboard.SetText(s)
            'End If

        Else
            S = S + "Select " + vbCrLf
            S += vbTab + "[SourceName] 	" + vbCrLf
            S += vbTab + ",[CreateDate] " + vbCrLf
            S += vbTab + ",[VersionNbr] 	" + vbCrLf
            S += vbTab + ",[LastAccessDate] " + vbCrLf
            S += vbTab + ",[FileLength] " + vbCrLf
            S += vbTab + ",[LastWriteTime] " + vbCrLf
            S += vbTab + ",[OriginalFileType] 		" + vbCrLf
            S += vbTab + ",[isPublic] " + vbCrLf
            S += vbTab + ",[FQN] " + vbCrLf
            S += vbTab + ",[SourceGuid] " + vbCrLf
            S += vbTab + ",[DataSourceOwnerUserID], FileDirectory, RetentionExpirationDate, isMaster, StructuredData, RepoSvrName, Description, RssLinkFlg, isWebPage " + vbCrLf
            S += "FROM DataSource " + vbCrLf
            Dim JoinStr As String = genInnerJoin("C", "XXXX")
            JoinStr = "/* " + JoinStr + " 0002 */"
            S += JoinStr
        End If

        Return S

    End Function

    Function DocSearchGenColsPaging(ByVal ckWeighted As Boolean, ByVal searchCriteria As String) As String

        Dim ckBusiness As Boolean = False
        Dim S As String = ""

        If ckWeighted = True Then
            S = S + "Select " + vbCrLf
            S += vbTab + "KEY_TBL.RANK ("
            S += vbTab + ",DS.SourceName" + vbCrLf
            S += vbTab + ",DS.CreateDate " + vbCrLf
            S += vbTab + ",DS.VersionNbr 	" + vbCrLf
            S += vbTab + ",DS.LastAccessDate " + vbCrLf
            S += vbTab + ",DS.FileLength " + vbCrLf
            S += vbTab + ",DS.LastWriteTime " + vbCrLf
            S += vbTab + ",DS.OriginalFileType 		" + vbCrLf
            S += vbTab + ",DS.isPublic " + vbCrLf
            S += vbTab + ",DS.FQN " + vbCrLf
            S += vbTab + ",DS.SourceGuid " + vbCrLf
            S += vbTab + ",DS.DataSourceOwnerUserID, "
            S += vbTab + ",DS.FileDirectory "
            S += vbTab + ",DS.RetentionExpirationDate "
            S += vbTab + ",DS.isMaster "
            S += vbTab + ",DS.StructuredData, DS.Description, DS.RssLinkFlg, DS.isWebPage " + vbCrLf
            S += vbTab + ",ROW_NUMBER() OVER (ORDER BY SourceName ASC) AS ROWID, RepoSvrName  )" + vbCrLf
            S += "FROM DataSource as DS " + vbCrLf

            Dim JoinStr As String = genInnerJoin("C", "XXXX")
            JoinStr = "/* " + JoinStr + " 0003 */"
            S += JoinStr
            S += genIsAbout(ckWeighted, ckBusiness, searchCriteria.Trim, False)

            'If bSaveToClipBoard Then
            'Clipboard.SetText(s)
            'End If

        Else
            S = S + "Select " + vbCrLf
            S += vbTab + "[SourceName] 	" + vbCrLf
            S += vbTab + ",[CreateDate] " + vbCrLf
            S += vbTab + ",[VersionNbr] 	" + vbCrLf
            S += vbTab + ",[LastAccessDate] " + vbCrLf
            S += vbTab + ",[FileLength] " + vbCrLf
            S += vbTab + ",[LastWriteTime] " + vbCrLf
            S += vbTab + ",[OriginalFileType] 		" + vbCrLf
            S += vbTab + ",[isPublic] " + vbCrLf
            S += vbTab + ",[FQN] " + vbCrLf
            S += vbTab + ",[SourceGuid] " + vbCrLf
            S += vbTab + ",[DataSourceOwnerUserID]"
            S += vbTab + ", FileDirectory"
            S += vbTab + ", RetentionExpirationDate"
            S += vbTab + ", isMaster"
            S += vbTab + ", StructuredData, Description, RssLinkFlg, isWebPage  " + vbCrLf
            S += vbTab + ",ROW_NUMBER() OVER (ORDER BY SourceName ASC) AS ROWID, RepoSvrName  " + vbCrLf
            S += "FROM DataSource " + vbCrLf
            Dim JoinStr As String = genInnerJoin("C", "XXXX")
            JoinStr = "/* " + JoinStr + " 0004 */"
            S += JoinStr
        End If

        Return S

    End Function

    Function genIsAbout(ByVal ckWeighted As Boolean, ByVal useFreetext As Boolean, ByVal SearchText As String, ByVal isEmailSearch As Boolean) As String
        If ckWeighted = False Then
            Return ""
        End If
        Dim isAboutClause As String = ""
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

    Function CleanIsAboutSearchText(ByVal SearchText As String) As String
        Dim I As Integer = 0
        Dim A As New ArrayList
        Dim CH As String = ""
        Dim Token As String = ""
        Dim S As String = ""
        Dim SkipNextToken As Boolean = False
        For I = 1 To SearchText.Trim.Length
REEVAL:
            CH = Mid(SearchText, I, 1)
            If CH.Equals(Chr(34)) Then
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
                Do While CH <> Chr(34) And I <= SearchText.Length
                    I += 1
                    CH = Mid(SearchText, I, 1)
                    Token += CH
                Loop
                'Token = Chr(34) + Token
                If PreceedingPlusSign = True Then
                    Token = "+" + Chr(34) + Token
                    'Dim NextChar$ = getNextChar(SearchText, I)
                    'If NextChar$ = "-" Then
                    '    '** We skip the next token in the stmt
                    'End If
                ElseIf PreceedingMinusSign = True Then
                    Token = "-" + Chr(34) + Token
                    'Dim NextChar$ = getNextChar(SearchText, I)
                    'If NextChar$ = "+" Then
                    '    '** We skip the next token in the stmt
                    'End If
                Else
                    Token = Chr(34) + Token
                End If
                A.Add(Token)

                Token = ""
            ElseIf CH.Equals(" ") Or CH = " " Then
                '** Skip the blank spaces
                If Token.Equals("+") Or Token.Equals("-") Then
                    Debug.Print("Should not be here.")
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
            Dim tWord As String = A(I)
            tWord = UCase(tWord)
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
                End If
            End If
        Next

        Return S
    End Function

    Function getNextChar(ByVal S As String, ByVal i As Integer) As String
        Dim CH As String = ""
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

    Function EmailSearchWithinLastXDays(ByVal DaysOld As String, ByVal SetWeight As Boolean) As String
        If SetWeight = False Then
            Return String.Empty
        End If

        Dim S As String = String.Empty
        S += " and (CreationTime >= GETDATE() - " + DaysOld + " or SentOn  >= GETDATE() - " + DaysOld.ToString + " )"

        Return S
    End Function

    Function EmailSearchAllReceipients(ByVal Name As String, ByVal Mandatory As Boolean) As String

        Name = Name.Trim
        If Name.Length = 0 Then
            Return String.Empty
        End If

        Dim S As String = String.Empty

        If Mandatory = True Then
            S += " AND "
        Else
            S += " OR "
        End If

        S = S + " (AllRecipients like '" + FixSingleQuote(Name) + "' or "
        S = S + "      CC like '" + FixSingleQuote(Name) + "' or "
        S = S + "      BCC like '" + FixSingleQuote(Name) + "') " + vbCrLf

        Return S
    End Function

    Function EmailSearchMyEmailsOnly(ByVal CurrUserID As String, ByVal bLimitReturn As Boolean, ByVal bIsGlobalSearcher As Boolean) As String

        Dim S As String = String.Empty

        If bIsGlobalSearcher = False Then
            S += " AND (where UserID = '" + CurrUserID + "' or isPublic = 'Y' )"
            Return S
        End If

        If bLimitReturn = False Then
            Return String.Empty
        End If

        S += " AND (where UserID = '" + CurrUserID + "' or isPublic = 'Y' )"

        Return S
    End Function

    Function EmailSearchCcBcc(ByVal Name As String, ByVal Mandatory As Boolean) As String

        Name = Name.Trim
        If Name.Length = 0 Then
            Return String.Empty
        End If

        Dim S As String = String.Empty

        If Mandatory = True Then
            S += " AND "
        Else
            S += " OR "
        End If

        S = S + " (CC like '" + FixSingleQuote(Name) + "' or " + vbCrLf
        S = S + " BCC like '" + FixSingleQuote(Name) + "')  " + vbCrLf

        Return S
    End Function

    Function EmailSearchSubject(ByVal Name As String, ByVal Mandatory As Boolean) As String

        Name = Name.Trim
        If Name.Length = 0 Then
            Return String.Empty
        End If

        Dim S As String = String.Empty

        If Mandatory = True Then
            S += " AND "
        Else
            S += " OR "
        End If

        S = S + " (SUBJECT Like '" + Name + "') " + vbCrLf

        Return S
    End Function

    Function EmailSearchByFolder(ByVal Name As String, ByVal Mandatory As Boolean) As String

        Name = Name.Trim
        If Name.Length = 0 Then
            Return String.Empty
        End If

        Dim S As String = String.Empty

        If Mandatory = True Then
            S += " AND "
        Else
            S += " OR "
        End If

        S = S + " (OriginalFolder LIKE '" + FixSingleQuote(Name) + "') " + vbCrLf

        Return S
    End Function

    Function EmailSearchReceivedByName(ByVal Name As String, ByVal Mandatory As Boolean) As String

        Name = Name.Trim
        If Name.Length = 0 Then
            Return String.Empty
        End If

        Dim S As String = String.Empty

        If Mandatory = True Then
            S += " AND "
        Else
            S += " OR "
        End If

        S = S + " (ReceivedByName like '" + FixSingleQuote(Name) + "') " + vbCrLf

        Return S
    End Function

    Function EmailAccount(ByVal Name As String, ByVal Mandatory As Boolean) As String

        Return EmailSearchReceivedByName(Name, Mandatory)

    End Function

    Function EmailSearchFromName(ByVal Name As String, ByVal Mandatory As Boolean) As String

        Name = Name.Trim
        If Name.Length = 0 Then
            Return String.Empty
        End If

        Dim S As String = String.Empty

        If Mandatory = True Then
            S += " AND "
        Else
            S += " OR "
        End If

        S = S + " (SenderName like '" + FixSingleQuote(Name) + "') " + vbCrLf

        Return S
    End Function

    Function EmailSearchToEmailAddr(ByVal EmailAddr As String, ByVal Mandatory As Boolean) As String

        EmailAddr = EmailAddr.Trim
        If EmailAddr.Length = 0 Then
            Return String.Empty
        End If

        Dim S As String = String.Empty

        If Mandatory = True Then
            S += " AND "
        Else
            S += " OR "
        End If

        S = S + " ( SentTO like '" + FixSingleQuote(EmailAddr) + "' or" + vbCrLf
        S = S + " AllRecipients like '" + FixSingleQuote(EmailAddr) + "') " + vbCrLf

        Return S
    End Function

    Function EmailSearchFromEmailAddr(ByVal EmailAddr As String, ByVal Mandatory As Boolean) As String

        EmailAddr = EmailAddr.Trim
        If EmailAddr.Length = 0 Then
            Return String.Empty
        End If

        Dim S As String = String.Empty

        If Mandatory = True Then
            S += " AND "
        Else
            S += " OR "
        End If

        S = S + " (SenderEmailAddress like '" + FixSingleQuote(EmailAddr) + "') " + vbCrLf

        Return S
    End Function

    Function EmailSearchDateLimits(ByVal ckDate As Boolean, _
                           ByVal DATECODE As String, _
                           ByVal Mandatory As Boolean, _
                           ByVal bSent As Boolean, _
                           ByVal bReceived As Boolean, _
                           ByVal bCreated As Boolean, _
                           ByVal Startdate As Date, _
                           ByVal EndDate As Date) As String

        If Not ckDate Then
            Return String.Empty
        End If

        Dim S As String = String.Empty

        Select Case DATECODE
            Case "AFTER"
                If bSent Then       'SentOn
                    If Mandatory = True Then
                        S += " AND "
                    Else
                        S += " OR "
                    End If
                    S += " (SentOn > '" + CDate(Startdate).ToString + "')" + vbCrLf
                End If
                If bReceived Then   'ReceivedTime
                    If Mandatory = True Then
                        S += " AND "
                    Else
                        S += " OR "
                    End If
                    S += " (ReceivedTime > '" + CDate(Startdate).ToString + "')" + vbCrLf
                End If
                If bCreated Then    'CreateDate
                    If Mandatory = True Then
                        S += " AND "
                    Else
                        S += " OR "
                    End If
                    S += " (CreateDate > '" + CDate(Startdate).ToString + "')" + vbCrLf
                End If
            Case "BEFORE"
                If bSent Then       'SentOn
                    If Mandatory = True Then
                        S += " AND "
                    Else
                        S += " OR "
                    End If
                    S += " (SentOn < '" + CDate(Startdate).ToString + "')" + vbCrLf
                End If
                If bReceived Then   'ReceivedTime
                    If Mandatory = True Then
                        S += " AND "
                    Else
                        S += " OR "
                    End If
                    S += " (ReceivedTime < '" + CDate(Startdate).ToString + "')" + vbCrLf
                End If
                If bCreated Then    'CreateDate
                    If Mandatory = True Then
                        S += " AND "
                    Else
                        S += " OR "
                    End If
                    S += " (CreateDate < '" + CDate(Startdate).ToString + "')" + vbCrLf
                End If
            Case "BETWEEN"
                If bSent Then       'SentOn
                    If Mandatory = True Then
                        S += " AND "
                    Else
                        S += " OR "
                    End If
                    S += " (SentOn >= '" + CDate(Startdate).ToString + "' AND SentOn <= '" + CDate(EndDate).ToString + "')" + vbCrLf
                End If
                If bReceived Then   'ReceivedTime
                    If Mandatory = True Then
                        S += " AND "
                    Else
                        S += " OR "
                    End If
                    S += " (ReceivedTime >= '" + CDate(Startdate).ToString + "' AND ReceivedTime <= '" + CDate(EndDate).ToString + "')" + vbCrLf
                End If
                If bCreated Then    'CreateDate
                    If Mandatory = True Then
                        S += " AND "
                    Else
                        S += " OR "
                    End If
                    S += " (CreateDate >= '" + CDate(Startdate).ToString + "' AND CreateDate <= '" + CDate(EndDate).ToString + "')" + vbCrLf
                End If
            Case "NOT BETWEEN"
                If bSent Then       'SentOn
                    If Mandatory = True Then
                        S += " AND "
                    Else
                        S += " OR "
                    End If
                    S += " (SentOn <= '" + CDate(Startdate).ToString + "' AND SentOn >= '" + CDate(EndDate).ToString + "')" + vbCrLf
                End If
                If bReceived Then   'ReceivedTime
                    If Mandatory = True Then
                        S += " AND "
                    Else
                        S += " OR "
                    End If
                    S += " (ReceivedTime <= '" + CDate(Startdate).ToString + "' AND ReceivedTime >= '" + CDate(EndDate).ToString + "')" + vbCrLf
                End If
                If bCreated Then    'CreateDate
                    If Mandatory = True Then
                        S += " AND "
                    Else
                        S += " OR "
                    End If
                    S += " (CreateDate <= '" + CDate(Startdate).ToString + "' AND CreateDate >= '" + CDate(EndDate).ToString + "')" + vbCrLf
                End If
            Case "ON"
                If bSent Then       'SentOn
                    If Mandatory = True Then
                        S += " AND "
                    Else
                        S += " OR "
                    End If
                    S += " (SentOn = '" + CDate(Startdate).ToString + "')" + vbCrLf
                End If
                If bReceived Then   'ReceivedTime
                    If Mandatory = True Then
                        S += " AND "
                    Else
                        S += " OR "
                    End If
                    S += " (ReceivedTime = '" + CDate(Startdate).ToString + "')" + vbCrLf
                End If
                If bCreated Then    'CreateDate
                    If Mandatory = True Then
                        S += " AND "
                    Else
                        S += " OR "
                    End If
                    S += " (CreateDate = '" + CDate(Startdate).ToString + "')" + vbCrLf
                End If
            Case Else
                S = String.Empty
        End Select

        Return S

    End Function
    Public Function EmailGenColsNoWeights(ByVal ContainsClause As String) As String
        Dim S As String = ""

        ContainsClause = FixSingleQuote(ContainsClause)

        S = S + " SELECT     Email.SentOn, Email.ShortSubj, Email.SenderEmailAddress, Email.SenderName, Email.SentTO, SUBSTRING(Email.Body, 1, 100) AS Body, Email.CC, Email.Bcc, " + vbCrLf
        S = S + "                       Email.CreationTime, Email.AllRecipients, Email.ReceivedByName, Email.ReceivedTime, Email.MsgSize, Email.SUBJECT, Email.OriginalFolder, Email.EmailGuid, " + vbCrLf
        S = S + "                       Email.RetentionExpirationDate, Email.isPublic, Email.ConvertEmlToMSG, Email.UserID, Email.NbrAttachments, Email.SourceTypeCode, 'N' AS FoundInAttachment," + vbCrLf
        S = S + "                       EmailAttachment.RowID" + vbCrLf
        S = S + " FROM         Email FULL OUTER JOIN" + vbCrLf
        S = S + "                       EmailAttachment ON Email.EmailGuid = EmailAttachment.EmailGuid" + vbCrLf
        S = S + " WHERE" + vbCrLf
        S = S + " (" + vbCrLf
        S = S + " CONTAINS(Email.*, '" + ContainsClause + "') OR" + vbCrLf
        S = S + " CONTAINS(EmailAttachment.*, '" + ContainsClause + "') " + vbCrLf
        S = S + " ) " + vbCrLf

        Return S

    End Function

    Public Function EmailGenColsNoWeights() As String

        Dim S As String = ""

        S = S + " SELECT     Email.SentOn, Email.ShortSubj, Email.SenderEmailAddress, Email.SenderName, Email.SentTO, SUBSTRING(Email.Body, 1, 100) AS Body, Email.CC, Email.Bcc, " + vbCrLf
        S = S + "                       Email.CreationTime, Email.AllRecipients, Email.ReceivedByName, Email.ReceivedTime, Email.MsgSize, Email.SUBJECT, Email.OriginalFolder, Email.EmailGuid, " + vbCrLf
        S = S + "                       Email.RetentionExpirationDate, Email.isPublic, Email.ConvertEmlToMSG, Email.UserID, Email.NbrAttachments, Email.SourceTypeCode, 'N' AS FoundInAttachment," + vbCrLf
        S = S + "                       EmailAttachment.RowID" + vbCrLf
        S = S + " FROM         Email FULL OUTER JOIN" + vbCrLf
        S = S + "                       EmailAttachment ON Email.EmailGuid = EmailAttachment.EmailGuid" + vbCrLf
        S = S + " WHERE" + vbCrLf

        Return S

    End Function

    Sub genNewEmailQuery(ByRef GeneratedSql As String)
        Dim a$() = GeneratedSql.Split(vbCrLf)
        Dim S As String = ""
        Dim bNextWhereStmt As Boolean = False
        Dim bGenNewSql As Boolean = False
        Dim NewSql As String = ""
        Dim StdQueryCols As String = Me.genStdEmailQqueryCols(0)
        Dim doNotAppend As Boolean = False
        Dim bContainsTable As Boolean = False

        For i As Integer = 0 To UBound(a)
            S = a(i)
            S = S.Trim

            If InStr(S, "FROM EMAIL ", CompareMethod.Text) > 0 Then
                bNextWhereStmt = True
            End If

            If InStr(S, "INNER JOIN CONTAINSTABLE", CompareMethod.Text) > 0 And bNextWhereStmt = True Then
                bGenNewSql = True
            End If

            If InStr(S, "WHERE", CompareMethod.Text) > 0 And bNextWhereStmt = True Then
                If Left(S, 5).ToUpper.Equals("WHERE") Then
                    bNextWhereStmt = False
                    bGenNewSql = True
                End If
            End If

            If InStr(S, "CONTAINS", CompareMethod.Text) > 0 Then
                If Left(S, "CONTAINS".Length).ToUpper.Equals("CONTAINS") Then
                    Dim TempStr$ = RemoveSpaces(S)
                    TempStr$ = TempStr$.ToUpper
                    If InStr(TempStr, "CONTAINS(*", CompareMethod.Text) > 0 Then
                        Dim k As Integer = InStr(S, "*")
                        Dim S1 As String = ""
                        Dim S2 As String = ""
                        S1 = Mid(S, 1, k - 1)
                        S2 = Mid(S, k + 1)
                        S = S1 + "Email.*" + S2
                        a(i) = S
                    End If
                End If
            End If

            If InStr(S, "order by", CompareMethod.Text) > 0 And bGenNewSql = True Then
                If Left(S, 8).ToUpper.Equals("ORDER BY") Then
                    doNotAppend = True
                    a(i) = ""
                    Exit For
                End If
            End If

            If bGenNewSql = True And doNotAppend = False And a(i).Trim.Length > 0 Then
                NewSql$ = NewSql$ + vbCrLf + a(i)
            End If

        Next

        NewSql$ = StdQueryCols + vbCrLf + NewSql$
        GeneratedSql = NewSql

        'Clipboard.Clear()
        'Clipboard.SetText(NewSql)

    End Sub

    Sub genNewEmailAttachmentQuery(ByRef GeneratedSql As String)

        Dim a$() = GeneratedSql.Split(vbCrLf)
        Dim S As String = ""
        Dim bNextWhereStmt As Boolean = False
        Dim bGenNewSql As Boolean = False
        Dim NewSql As String = ""
        Dim StdQueryCols As String = genStdEmailAttachmentQqueryCols(0)
        Dim doNotAppend As Boolean = False

        For i As Integer = 0 To UBound(a)
            S = a(i)
            S = S.Trim

            If InStr(S, "FROM EMAIL ", CompareMethod.Text) > 0 Then
                bNextWhereStmt = True
            End If

            If InStr(S, "JOIN CONTAINSTABLE", CompareMethod.Text) > 0 And bNextWhereStmt = True Then
                bGenNewSql = True
            End If

            If InStr(S, "WHERE", CompareMethod.Text) > 0 And bNextWhereStmt = True Then
                If Left(S, 5).ToUpper.Equals("WHERE") Then
                    bNextWhereStmt = False
                    bGenNewSql = True
                End If
            End If

            If InStr(S, "CONTAINS(body", CompareMethod.Text) > 0 Then
                Dim TempStr$ = RemoveSpaces(S)
                Dim k As Integer = InStr(S, "CONTAINS(body", CompareMethod.Text)
                k = InStr(k + 1, S, "(", CompareMethod.Text)
                Dim L As Integer = InStr(k + 1, S, ",")
                Dim S1 As String = ""
                Dim S2 As String = ""
                Dim tPart$ = Mid(S, k, L - k + 1)
                S1 = Mid(S, 1, k)
                S2 = Mid(S, L)
                S = S1 + "Attachment" + S2
                a(i) = S
            End If

            If InStr(S, "or CONTAINS(", CompareMethod.Text) > 0 Then
                a(i) = ""
            End If

            If InStr(S, "order by", CompareMethod.Text) > 0 And bGenNewSql = True Then
                If Left(S, 8).ToUpper.Equals("ORDER BY") Then
                    doNotAppend = True
                    a(i) = ""
                    Exit For
                End If
            End If

            If InStr(S, "Select EmailGuid from EmailAttachmentSearchList", CompareMethod.Text) > 0 Then
                a(i) = ""
            End If
            If InStr(S, "OR", CompareMethod.Text) > 0 Then
                If InStr(S, "select", CompareMethod.Text) > 0 Then
                    If InStr(S, "EmailGuid", CompareMethod.Text) > 0 Then
                        If InStr(S, "EmailAttachmentSearchList", CompareMethod.Text) > 0 Then
                            a(i) = ""
                        End If
                    End If
                End If
            End If

            If bGenNewSql = True And doNotAppend = False And a(i).Trim.Length > 0 Then
                NewSql$ = NewSql$ + vbCrLf + a(i)
            End If

        Next

        NewSql$ = StdQueryCols + vbCrLf + NewSql$
        GeneratedSql = NewSql

        'Clipboard.Clear()
        'Clipboard.SetText(NewSql)

    End Sub

    Sub genNewDocQuery(ByRef GeneratedSql As String)
        Dim a$() = GeneratedSql.Split(vbCrLf)
        Dim S As String = ""
        Dim bNextWhereStmt As Boolean = False
        Dim bGenNewSql As Boolean = False
        Dim NewSql As String = ""
        Dim StdQueryCols As String = genStdDocQueryCols(0)
        Dim doNotAppend As Boolean = False

        For i As Integer = 0 To UBound(a)
            S = a(i)
            S = S.Trim

            If InStr(S, "FROM ", CompareMethod.Text) > 0 Then
                If InStr(S, "DataSource", CompareMethod.Text) > 0 Then
                    If Left(S, "FROM".Length).ToUpper.Equals("FROM") Then
                        bNextWhereStmt = True
                    End If
                End If
            End If

            If InStr(S, "JOIN CONTAINSTABLE", CompareMethod.Text) > 0 And bNextWhereStmt = True Then
                Console.WriteLine("Here")
                bGenNewSql = True
            End If

            If InStr(S, "WHERE", CompareMethod.Text) > 0 And bNextWhereStmt = True Then
                If Left(S, 5).ToUpper.Equals("WHERE") Then
                    bNextWhereStmt = False
                    bGenNewSql = True
                End If
            End If

            If InStr(S, "CONTAINS", CompareMethod.Text) > 0 Then
                If Left(S, "CONTAINS".Length).ToUpper.Equals("CONTAINS") Then
                    Dim TempStr$ = RemoveSpaces(S)
                    TempStr$ = TempStr$.ToUpper
                    If InStr(TempStr, "CONTAINS(*", CompareMethod.Text) > 0 Then
                        Dim k As Integer = InStr(S, "*")
                        Dim S1 As String = ""
                        Dim S2 As String = ""
                        S1 = Mid(S, 1, k - 1)
                        S2 = Mid(S, k + 1)
                        S = S1 + "DataSource.*" + S2
                        a(i) = S
                    End If
                End If
            End If

            If InStr(S, "order by", CompareMethod.Text) > 0 And bGenNewSql = True Then
                If Left(S, 8).ToUpper.Equals("ORDER BY") Then
                    doNotAppend = True
                    a(i) = ""
                    Exit For
                End If
            End If

            If bGenNewSql = True And doNotAppend = False And a(i).Trim.Length > 0 Then
                NewSql$ = NewSql$ + vbCrLf + a(i)
            End If

        Next

        NewSql$ = StdQueryCols + vbCrLf + NewSql$
        GeneratedSql = NewSql$

        'Clipboard.Clear()
        'Clipboard.SetText(GeneratedSql)

    End Sub

    Function genStdEmailQqueryCols(iMaxRows As Integer) As String
        Dim S As String = ""
        Dim Prefix As String = ""
        If iMaxRows > 0 Then
            S = S + "Select top " + iMaxRows.ToString + " " + vbCrLf
        Else
            S = S + "Select " + vbCrLf
        End If

        If UseWeights = True Then
            S = S + vbTab + "KEY_TBL.RANK as Weight, " + vbCrLf
            Prefix = "DS."
        Else
            S = S + vbTab + "null as Weight, " + vbCrLf
            Prefix = ""
        End If

        S = S + vbTab + "Email.ShortSubj as ContentTitle, " + vbCrLf
        S = S + vbTab + "(select COUNT(*) from EmailAttachment where EmailAttachment.EmailGuid = Email.EmailGuid) as NbrOfAttachments, " + vbCrLf
        S = S + vbTab + "Email.SenderEmailAddress AS ContentAuthor, " + vbCrLf
        S = S + vbTab + "Email.SourceTypeCode as  ContentExt, " + vbCrLf
        S = S + vbTab + "Email.CreationTime AS CreateDate, " + vbCrLf
        S = S + vbTab + "Email.ShortSubj as  FileName, " + vbCrLf
        S = S + vbTab + "Email.AllRecipients, " + vbCrLf
        S = S + vbTab + "Email.EmailGuid as ContentGuid, " + vbCrLf
        S = S + vbTab + "Email.MsgSize  as FileSize, " + vbCrLf
        S = S + vbTab + "Email.SenderEmailAddress AS FromEmailAddress, " + vbCrLf
        'S = S + vbTab + "Users.UserLoginID, " + vbCrLf
        S = S + "(Select UserLoginID from Users where email.UserID = Users.UserID) as UserLoginUD, " + vbCrLf
        S = S + vbTab + "Email.USERID, " + vbCrLf
        S = S + vbTab + "null as RowID, " + vbCrLf
        S = S + vbTab + "'EMAIL' AS Classification, " + vbCrLf
        S = S + vbTab + "null as isZipFileEntry, " + vbCrLf
        S = S + vbTab + "null as OcrText, " + vbCrLf
        S = S + vbTab + "email.ispublic " + vbCrLf

        If UseWeights = True Then
            S = S + vbTab + "FROM Email as DS "
            Dim JoinStr As String = genInnerJoin("E", "XXXX")
            JoinStr = "/* " + JoinStr + " 0005 */"
            S += JoinStr
            S = ReplacePrefix(Prefix, "email.", S)
        Else
            S = S + vbTab + "FROM Email "
            Dim JoinStr As String = genInnerJoin("E", "XXXX")
            JoinStr = "/* " + JoinStr + " 0006 */"
            S += JoinStr
        End If

        Return S
    End Function

    Function genStdEmailAttachmentQqueryCols(iMaxRows As Integer) As String

        Dim Prefix$ = "DS."
        Dim S As String = ""
        If iMaxRows > 0 Then
            S = S + "Select top " + iMaxRows.ToString + " " + vbCrLf
        Else
            S = S + "Select " + vbCrLf
        End If

        If UseWeights = True Then
            S = S + vbTab + "KEY_TBL.RANK as Weight, " + vbCrLf
        Else
            S = S + vbTab + "null as Weight, " + vbCrLf
        End If

        S = S + vbTab + "EmailAttachment.AttachmentName as ContentTitle, " + vbCrLf
        S = S + vbTab + "null as NbrOfAttachments, " + vbCrLf
        S = S + vbTab + "(select SenderEmailAddress from EMAIL where EmailAttachment.EmailGuid = EMAIL.EmailGuid) as ContentAuthor, " + vbCrLf
        S = S + vbTab + "EmailAttachment.AttachmentCode as ContentExt, " + vbCrLf
        S = S + vbTab + "(select CreationTime from EMAIL where EmailAttachment.EmailGuid = EMAIL.EmailGuid) as CreateDate, " + vbCrLf
        S = S + vbTab + "EmailAttachment.AttachmentName as FileName, " + vbCrLf
        S = S + vbTab + "null as AllRecipients, " + vbCrLf
        S = S + vbTab + "EmailAttachment.EmailGuid as ContentGuid, " + vbCrLf
        S = S + vbTab + "DATALENGTH(EmailAttachment.Attachment) as FileSize, " + vbCrLf
        S = S + vbTab + "(select SenderEmailAddress  from EMAIL where EmailAttachment.EmailGuid = EMAIL.EmailGuid) as FromEmailAddress, " + vbCrLf
        S = S + vbTab + "(Select UserLoginID from Users where EmailAttachment.UserID = Users.UserID) as UserLoginUD, " + vbCrLf
        S = S + vbTab + "EmailAttachment.UserID, " + vbCrLf
        S = S + vbTab + "EmailAttachment.RowID, " + vbCrLf
        S = S + vbTab + "'Attachment' as Classification, " + vbCrLf
        S = S + vbTab + "EmailAttachment.isZipFileEntry, " + vbCrLf
        S = S + vbTab + "EmailAttachment.OcrText, " + vbCrLf
        S = S + vbTab + "EmailAttachment.isPublic "

        If UseWeights = True Then
            S = S + vbTab + "FROM EmailAttachment as DS " + vbCrLf

            Dim JoinStr As String = genInnerJoin("A", "XXXX")
            JoinStr = "/* " + JoinStr + " 0007 */"
            S += JoinStr

            S = ReplacePrefix(Prefix, "EmailAttachment.", S)
        Else
            S = S + vbTab + "FROM EmailAttachment " + vbCrLf

            Dim JoinStr As String = genInnerJoin("A", "XXXX")
            JoinStr = "/* " + JoinStr + " 0008 */"
            S += JoinStr

        End If

        Return S
    End Function

    Function genStdDocQueryCols(iMaxRows As Integer) As String

        Dim Prefix$ = "DS."
        Dim S As String = ""
        If iMaxRows > 0 Then
            S = S + "Select top " + iMaxRows.ToString + " " + vbCrLf
        Else
            S = S + "Select " + vbCrLf
        End If

        If UseWeights = True Then
            S = S + vbTab + "KEY_TBL.RANK as Weight, " + vbCrLf
        Else
            S = S + vbTab + "null as Weight, " + vbCrLf
        End If

        S = S + vbTab + "DataSource.SourceName as ContentTitle, " + vbCrLf
        S = S + vbTab + "null as NbrOfAttachments, " + vbCrLf
        S = S + vbTab + "null as ContentAuthor, " + vbCrLf
        S = S + vbTab + "DataSource.OriginalFileType as ContentExt, " + vbCrLf
        S = S + vbTab + "DataSource.CreateDate, " + vbCrLf
        S = S + vbTab + "DataSource.FQN as FileName, " + vbCrLf
        S = S + vbTab + "null as AllRecipients, " + vbCrLf
        S = S + vbTab + "DataSource.SourceGuid as ContentGuid, " + vbCrLf
        S = S + vbTab + "DataSource.FileLength  as FileSize, " + vbCrLf
        S = S + vbTab + "null as FromEmailAddress, " + vbCrLf
        'S = S + vbTab + "Users.UserLoginID, " + vbCrLf
        S = S + "(Select UserLoginID from Users where DataSource.DataSourceOwnerUserID = Users.UserID) as UserLoginUD, " + vbCrLf
        S = S + vbTab + "DataSource.DataSourceOwnerUserID as UserID, " + vbCrLf
        S = S + vbTab + "null as RowID, " + vbCrLf
        S = S + vbTab + "'Content' as Classification, " + vbCrLf
        S = S + vbTab + "DataSource.isZipFileEntry, " + vbCrLf
        S = S + vbTab + "null as OcrText, " + vbCrLf
        S = S + vbTab + "DataSource.isPublic, DataSource.RepoSvrName  " + vbCrLf

        If UseWeights = True Then
            S = S + vbTab + "FROM DataSource as DS "
            S = ReplacePrefix(Prefix, "DataSource.", S)
        Else
            S = S + vbTab + "FROM DataSource "
        End If

        Return S
    End Function
    Function RemoveSpaces(ByVal sText As String) As String
        Dim A$() = Split(sText, " + vbcrlf ")
        Dim S As String = ""
        For i As Integer = 0 To UBound(A)
            S = S + A(i)
        Next
        Return S
    End Function

    Function ReplacePrefix(ByVal NewPrefix As String, ByVal PrefixToReplace As String, ByVal tgtStr As String) As String
        Dim NewStr As String = ""
        Dim I As Integer = 0
        Dim J As Integer = 0
        Dim S$ = tgtStr
        Dim S1 As String = ""
        Dim S2 As String = ""

        Do While InStr(S, PrefixToReplace$, CompareMethod.Text) > 0
            I = InStr(S, PrefixToReplace$, CompareMethod.Text)
            J = InStr(S, PrefixToReplace$, CompareMethod.Text) + PrefixToReplace$.Length
            S1 = Mid(S, 1, I - 1)
            S2 = Mid(S, J)
            S = S1 + NewPrefix + S2
            'Console.WriteLine(S)
        Loop

        Return S

    End Function

    Sub ReplaceStar(ByRef tVal As String)
        Dim CH As String = ""
        If InStr(tVal, "*") = 0 Then
            Return
        End If
        If tVal$.Length > 0 Then
            If tVal.Length > 1 Then
                CH = Mid(tVal, 1, 1)
                If CH.Equals("*") Then
                    Mid(tVal, 1, 1) = "%"
                End If
                CH = Mid(tVal, tVal.Length, 1)
                If CH.Equals("*") Then
                    Mid(tVal, tVal.Length, 1) = "%"
                End If
            End If
        End If
    End Sub

    Public Function FixSingleQuote(ByVal tVal As String) As String

        If InStr(tVal$, "''") > 0 Then
            Return (tVal)
        End If
        If InStr(tVal$, "'") = 0 Then
            Return (tVal)
        End If

        Dim SS$ = tVal$
        tVal = SS
        Try
            Dim i As Integer = Len(tVal)
            Dim ch As String = ""
            Dim NewStr As String = ""
            Dim S1 As String = ""
            Dim S2 As String = ""
            'Dim A$()
            Dim PrevCH$ = "@"
            i = InStr(1, tVal, "'")
            Do While InStr(1, tVal, "'") > 0
                i = InStr(1, tVal, "'")
                S1 = Mid(tVal, 1, i)
                Mid(S1, S1.Length, 1) = Chr(254)
                S2 = Chr(254) + Mid(tVal, i + 1)
                tVal$ = S1 + S2
            Loop

            For i = 1 To Len(tVal)
                ch = Mid(tVal, i, 1)
                If ch = Chr(254) Then
                    Mid(tVal, i, 1) = "'"
                End If
            Next
        Catch ex As Exception
            WriteToLog("ERROR: FixSingleQuote - " + ex.Message + vbCrLf + ex.StackTrace)
        End Try

        Return tVal
    End Function

    Public Sub WriteToLog(ByVal Msg As String)
        Try
            Dim cPath As String = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData)
            Dim TempFolder$ = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData)
            Dim M$ = Now.Month.ToString.Trim
            Dim D$ = Now.Day.ToString.Trim
            Dim Y$ = Now.Year.ToString.Trim

            Dim SerialNo$ = M + "." + D + "." + Y + "."

            Dim tFQN$ = TempFolder$ + "\ECMLibrary.Generator.Log." + SerialNo$ + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
            'If gRunUnattended = True Then
            '    gUnattendedErrors += 1
            '    'FrmMDIMain.SB4.Text = " " + gUnattendedErrors.ToString
            '    'FrmMDIMain.SB4.BackColor = Color.Silver
            'End If
        Catch ex As Exception
            Console.WriteLine("clsGenerator : WriteToLog : 688 : " + ex.Message)
        End Try
    End Sub

    Function buildContainsSyntax(ByRef SecureID As Integer, ByVal SearchCriteria As String, ByRef ThesaurusWords As ArrayList) As String
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
        Dim Ch As String = ""
        Dim tWord As String = ""
        Dim WordCnt As Integer = 0
        Dim isOr As Boolean = False
        Dim isAnd As Boolean = False
        Dim isNear As Boolean = False
        Dim isPhrase As Boolean = False
        Dim isAndNot As Boolean = False
        Dim Delimiters As String = " ,:"
        Dim DQ As String = Chr(34)
        Dim FirstEntry As Boolean = True
        Dim QuotedString As String = ""
        Dim AND_Needed As Boolean = False
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
                    If isDelimiter(SecureID, Ch) Then
                        SkipTokens(SecureID, SearchCriteria, I, J)
                        I = J
                        GoTo StartNextWord
                    End If
                End If

                FirstEntry = False
            End If
TokenAlreadyAcquired:
            If Ch = Chr(34) Then
                QuotedString = ""
                J = 0
                GetQuotedString(SecureID, SearchCriteria, I, J, QuotedString)
                If QuotedString$.Equals(Chr(34) + Chr(34)) Then
                    If dDebug Then Console.WriteLine("Skipping null double quotes.")
                Else
                    A.Add(QuotedString)
                End If

                AND_Needed = True
            ElseIf Ch.Equals("|") Then
                AND_Needed = False
                A.Add("Or")
            ElseIf Ch.Equals("+") Then
                A.Add("And")
                AND_Needed = False
            ElseIf Ch.Equals("-") Then
                A.Add("aNd nOt")
                AND_Needed = False
            ElseIf Ch.Equals("(") Then
                If dDebug Then Console.WriteLine("Skipping: " + Ch)
                A.Add("(")
            ElseIf Ch.Equals(")") Then
                If dDebug Then Console.WriteLine("Skipping: " + Ch)
                A.Add(")")
            ElseIf Ch.Equals(",") Then
                If dDebug Then Console.WriteLine("Skipping: " + Ch)
            ElseIf Ch = "^" Then
                '** Then this will be an inflectional term
                '** One term using the AND operator will be built for each inflectional term provided.
                Dim SubstituteString As String = "FORMSOF (INFLECTIONAL, " + Chr(34) + "@" + Chr(34) + ")"
                I += 1

                Dim ReturnedDelimiter As String = ""

                tWord = getNextToken(SecureID, SearchCriteria, I, ReturnedDelimiter)
                Dim C$ = Mid(SearchCriteria, I, 1)
                SubIn(SecureID, SubstituteString, "@", tWord)
                tWord = SubstituteString
                SubIn(SecureID, tWord, Chr(34) + Chr(34), Chr(34))

                'If AND_Needed Then
                '    A.Add("AND")
                'End If

                If dDebug Then Console.WriteLine(I.ToString + ":" + Mid(SearchCriteria, I, 1))
                A.Add(tWord)
                AND_Needed = True
                tWord = ""
                GoTo StartNextWord
            ElseIf Ch = "~" Then
                '** Then this will be a THESAURUS term
                '** One term using the AND operator will be built for each inflectional term provided.
                Dim SubstituteString As String = "FORMSOF (THESAURUS, " + Chr(34) + "@" + Chr(34) + ")"
                I += 1
                Dim ReturnedDelimiter As String = ""
                tWord = getNextToken(SecureID, SearchCriteria, I, ReturnedDelimiter)
                SubIn(SecureID, SubstituteString, "@", tWord)
                tWord = SubstituteString
                SubIn(SecureID, tWord, Chr(34) + Chr(34), Chr(34))
                'If A.Count > 1 Then
                '    A.Add("AND")
                '    AND_Needed = False
                'End If
                'If AND_Needed Then
                '    A.Add("AND")
                'End If
                If dDebug Then Console.WriteLine(I.ToString + ":" + Mid(SearchCriteria, I, 1))
                A.Add(tWord)
                AND_Needed = True
                tWord = ""
                GoTo StartNextWord
            ElseIf Ch = "#" Then
                '** Then this will be an THESAURUS term
                '** One term using the AND operator will be built for each inflectional term provided.
                Dim SubstituteString As String = "FORMSOF (THESAURUS, " + Chr(34) + "@" + Chr(34) + ")"
                I += 1
                Dim ReturnedDelimiter As String = ""
                tWord = getNextToken(SecureID, SearchCriteria, I, ReturnedDelimiter)
                If Not ThesaurusWords.Contains(tWord) Then
                    ThesaurusWords.Add(tWord)
                End If
                GoTo ProcessImmediately
            ElseIf Ch = " " Or Ch = "," Then
                I += 1
                Ch = Mid(SearchCriteria, I, 1)
                If isSyntaxChar(SecureID, Ch) Then
                    GoTo TokenAlreadyAcquired
                End If
                Do While Ch = " " And I < SearchCriteria.Length
                    Ch = Mid(SearchCriteria, I, 1)
                    I += 1
                Loop
                If isSyntaxChar(SecureID, Ch) Then
                    I = I - 1
                    GoTo TokenAlreadyAcquired
                End If
                isOr = True
                '************************************************************
                tWord = getTheRestOfTheToken(SecureID, SearchCriteria, I)
                '************************************************************
                'Dim sPrevWord As String = ""
                'If A.Count > 0 Then
                '    sPrevWord = A.Item(A.Count - 1)
                'End If
                'If UCase(tWord).Equals("OR") Then
                '    If sPrevWord.Trim.Length > 0 Then
                '        If isKeyWord(SecureID, sPrevWord) Then
                '            A.Item(A.Count - 1) = " "
                '        End If
                '    End If
                '    AND_Needed = False
                'ElseIf UCase(tWord).Equals("AND") Then
                '    If sPrevWord.Trim.Length > 0 Then
                '        If isKeyWord(SecureID, sPrevWord) Then
                '            A.Item(A.Count - 1) = " "
                '        End If
                '    End If
                '    AND_Needed = False
                'ElseIf UCase(tWord).Equals("NOT") Then
                '    If sPrevWord.Trim.Length > 0 Then
                '        If isKeyWord(SecureID, sPrevWord) Then
                '            A.Item(A.Count - 1) = " "
                '        End If
                '    End If
                '    AND_Needed = False
                'ElseIf UCase(tWord).Equals("NEAR") Then
                '    If sPrevWord.Trim.Length > 0 Then
                '        If isKeyWord(SecureID, sPrevWord) Then
                '            A.Item(A.Count - 1) = " "
                '        End If
                '    End If
                '    AND_Needed = False
                'ElseIf UCase(tWord).Equals("NOT") Then
                '    If sPrevWord.Trim.Length > 0 Then
                '        If isKeyWord(SecureID, sPrevWord) Then
                '            A.Item(A.Count - 1) = " "
                '        End If
                '    End If
                '    AND_Needed = False
                'Else
                '    AND_Needed = True
                'End If

                A.Add(tWord)
                Dim BB As Boolean = False
                BB = isKeyWord(SecureID, tWord)

                If BB = True Then
                    AND_Needed = False
                Else
                    AND_Needed = True
                End If
                tWord = ""
                I = I - 1
            Else
                Dim ReturnedDelimiter As String = ""
                tWord = getNextToken(SecureID, SearchCriteria, I, ReturnedDelimiter)
                'If dDebug Then Console.WriteLine(tWord)
                'Dim sPrevWord As String = ""
                'If A.Count > 0 Then
                '    sPrevWord = A.Item(A.Count - 1)
                'End If
                'If UCase(tWord).Equals("OR") Then
                '    If sPrevWord.Trim.Length > 0 Then
                '        If isKeyWord(SecureID, sPrevWord) Then
                '            A.Item(A.Count - 1) = " "
                '        End If
                '    End If
                '    AND_Needed = False
                'ElseIf UCase(tWord).Equals("AND") Then
                '    If sPrevWord.Trim.Length > 0 Then
                '        If isKeyWord(SecureID, sPrevWord) Then
                '            A.Item(A.Count - 1) = " "
                '        End If
                '    End If
                '    AND_Needed = False
                'ElseIf UCase(tWord).Equals("NOT") Then
                '    If sPrevWord.Trim.Length > 0 Then
                '        If isKeyWord(SecureID, sPrevWord) Then
                '            A.Item(A.Count - 1) = " "
                '        End If
                '    End If
                '    AND_Needed = False
                'ElseIf UCase(tWord).Equals("NEAR") Then
                '    If sPrevWord.Trim.Length > 0 Then
                '        If isKeyWord(SecureID, sPrevWord) Then
                '            A.Item(A.Count - 1) = " "
                '        End If
                '    End If
                '    AND_Needed = False
                'ElseIf UCase(tWord).Equals("NOT") Then
                '    If sPrevWord.Trim.Length > 0 Then
                '        If isKeyWord(SecureID, sPrevWord) Then
                '            A.Item(A.Count - 1) = " "
                '        End If
                '    End If
                '    AND_Needed = False
                'Else
                '    AND_Needed = True
                'End If

                A.Add(tWord)

                tWord = ""
                I = I - 1
            End If
ProcessImmediately:

            If dDebug Then Console.WriteLine(I.ToString + ":" + tWord)
            If dDebug Then Console.WriteLine(SearchCriteria)
            tWord = ""
            'isOr = True
            For II As Integer = 0 To A.Count - 1
                If A(II) = Nothing Then
                    If dDebug Then Console.WriteLine(II.ToString + ":Nothing")
                Else
                    If dDebug Then Console.WriteLine(II.ToString + ":" + A(II).ToString)
                End If
            Next

            'If AND_Needed Then
            '    A.Add("AND")
            'End If
NextWord:
        Next

        'BB = isKeyWord(SecureID, tWord)
        Dim ExpandedSearchString As String = ""
        Dim currWord As String = ""
        Dim prevWord As String = ""
        Dim iLoc As Integer = 0

        '** Contains Clause Generator
        For Each TempWord As String In A
            If iLoc = 0 Then
                If isKeyWord(SecureID, TempWord) Then
                    ExpandedSearchString = ""
                Else
                    ExpandedSearchString = TempWord
                End If
            Else
                If TempWord.Trim.Length = 0 Then

                ElseIf Not isKeyWord(SecureID, TempWord) And TempWord.Equals(")") Then
                    ExpandedSearchString = ExpandedSearchString.Trim + " " + TempWord
                ElseIf prevWord.Trim.ToUpper.Equals("(") And Not isKeyWord(SecureID, TempWord) Then
                    ExpandedSearchString = ExpandedSearchString + TempWord.Trim + " "
                ElseIf TempWord.Trim.ToUpper.Equals(")") And isKeyWord(SecureID, prevWord) Then
                    '** Correct the new generator issue from LIZ 9/16/2011 here.
                    ExpandedSearchString = ExpandedSearchString.Trim
                    For II As Integer = ExpandedSearchString.Length To 1 Step -1
                        Ch = Mid(ExpandedSearchString, II, 1)
                        If Ch.Equals(" ") Or Ch.Equals(",") Then
                            ExpandedSearchString = Mid(ExpandedSearchString, 1, II)
                            ExpandedSearchString = ExpandedSearchString.Trim
                            ExpandedSearchString = ExpandedSearchString + " " + ")"
                        End If
                    Next
                ElseIf TempWord.Trim.ToUpper.Equals("NEAR") And isKeyWord(SecureID, prevWord) Then
                    '** remove the last word in the string
                    ExpandedSearchString = ExpandedSearchString.Trim
                    For II As Integer = ExpandedSearchString.Length To 1 Step -1
                        Ch = Mid(ExpandedSearchString, II, 1)
                        If Ch.Equals(" ") Or Ch.Equals(",") Then
                            ExpandedSearchString = Mid(ExpandedSearchString, 1, II)
                            ExpandedSearchString = ExpandedSearchString.Trim
                            ExpandedSearchString = ExpandedSearchString + " " + "NEAR"
                        End If
                    Next
                ElseIf Not isKeyWord(SecureID, prevWord) And InStr(TempWord, "FORMSOF ") > 0 Then
                    ExpandedSearchString = ExpandedSearchString + " AND " + TempWord + " "
                ElseIf Not isKeyWord(SecureID, prevWord) And InStr(TempWord, "FORMSOF ") > 0 Then
                    ExpandedSearchString = ExpandedSearchString + " AND " + TempWord + " "
                ElseIf InStr(TempWord, Chr(34)) > 0 Then
                    ExpandedSearchString = ExpandedSearchString + " " + TempWord
                ElseIf isKeyWord(SecureID, TempWord) Then
                    ExpandedSearchString = ExpandedSearchString + " " + TempWord
                ElseIf Not isKeyWord(SecureID, prevWord) And Not isKeyWord(SecureID, TempWord) And Not isDelimeter(TempWord) Then
                    ExpandedSearchString = ExpandedSearchString + " AND " + TempWord + " "
                Else
                    ExpandedSearchString = ExpandedSearchString + " " + TempWord
                End If
            End If
            prevWord = TempWord
            iLoc += 1
        Next

        Return ExpandedSearchString

    End Function

    Sub GetQuotedString(ByVal tstr As String, ByRef i As Integer, ByRef j As Integer, ByRef QuotedString As String)
        Dim X As Integer = tstr.Trim.Length
        Dim Q$ = Chr(34)
        Dim CH As String = ""
        Dim Alphabet$ = " |+-^"
        Dim S As String = ""
        QuotedString$ = Q
        i += 1
        CH = Mid(tstr, i, 1)
        Do While CH <> Chr(34) And i <= tstr.Length
            QuotedString$ = QuotedString$ + CH
            i += 1
            CH = Mid(tstr, i, 1)
        Loop
        QuotedString$ = QuotedString$ + Q
    End Sub

    Function isNotDelimiter(ByVal CH As String) As Boolean
        Dim Alphabet$ = " |+-^"
        If InStr(1, Alphabet, CH) = 0 Then
            Return True
        Else
            Return False
        End If
    End Function

    Function isDelimiter(ByVal CH As String) As Boolean
        Dim Alphabet$ = " |+-^"
        If InStr(1, Alphabet, CH) > 0 Then
            Return True
        Else
            Return False
        End If
    End Function

    Sub SkipTokens(ByVal tstr As String, ByVal i As Integer, ByRef j As Integer)
        Dim X As Integer = tstr.Trim.Length
        Dim Q$ = Chr(34)
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

    Function getNextToken(ByVal S As String, ByRef I As Integer, ByRef ReturnedDelimiter As String) As String
        Dim Delimiters As String = " ,:+-^|()"
        S = S.Trim
        Dim Token As String = ""
        Dim CH As String = ""
        CH = Mid(S, I, 1)
        Dim KK As Integer = S.Length

        '** If CH is a blank char, skip to the start of the next token
        If CH = " " Then
            Do Until (CH <> " " And I <= KK)
                I += 1
                CH = Mid(S, I, 1)
            Loop
        End If

        If CH = Chr(34) Then
            Token = ""
            Token += Chr(34)
            I += 1
            CH = Mid(S, I, 1)
            KK = S.Length
            Do Until (CH = Chr(34) And I <= KK)
                Token += CH
                I += 1
                CH = Mid(S, I, 1)
                If I > S.Length Then
                    Exit Do
                End If
            Loop
            Token += Chr(34)
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

    Sub SubIn(ByRef ParentString As String, ByVal WhatToChange As String, ByVal ChangeCharsToThis As String)
        Dim I As Integer = 0
        Dim J As Integer = 0
        Dim M As Integer = 0
        Dim N As Integer = 0
        Dim S1 As String = ""
        Dim S2 As String = ""

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
    Sub SkipToNextToken(ByVal S As String, ByRef I As Integer)
        Dim Delimiters As String = " ,:+-^|"
        S = S.Trim
        Dim Token As String = ""
        Dim CH As String = ""
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

    Function isSyntaxChar(ByVal CH As String) As Boolean
        Dim Alphabet$ = "#|+-^~"
        If InStr(1, Alphabet, CH) > 0 Then
            Return True
        Else
            Return False
        End If
    End Function

    Function getTheRestOfTheToken(ByVal S As String, ByRef I As Integer) As String
        'We are sitting at the next character in the token, so go back to the beginning
        I = I - 1
        Dim Delimiters As String = " ,:+-^|"
        S = S.Trim
        Dim Token As String = ""
        Dim CH As String = ""
        CH = Mid(S, I, 1)
        Dim KK As Integer = S.Length

        '** If CH is a blank char, skip to the start of the next token
        If CH = " " Then
            Do Until (CH <> " " And I <= KK)
                I += 1
                CH = Mid(S, I, 1)
            Loop
        End If

        If CH = Chr(34) Then
            Token = ""
            Token += Chr(34)
            I += 1
            CH = Mid(S, I, 1)
            KK = S.Length
            Do Until (CH = Chr(34) And I <= KK)
                Token += CH
                I += 1
                CH = Mid(S, I, 1)
                If I > S.Length Then
                    Exit Do
                End If
            Loop
            Token += Chr(34)
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

    Public Function genLibrarySearch(ByVal CurrUserID As String, ByVal bSourceSearch As Boolean, ByVal bGlobalSearcher As Boolean, ByVal LocationID As String) As String

        Dim SearchCode As String = ""
        If bSourceSearch = True Then
            SearchCode = "S"
        Else
            SearchCode = "E"
        End If

        Dim S As String = ""

        If SearchCode.Equals("E") Or SearchCode.Equals("EMAIL") Then
            If bGlobalSearcher = True Then

                S = S + Chr(9) + "/* This is where the library search would go - you have global rights, think about it.*/" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf

                If SearchCode.Equals("S") Then
                    'S = S + Chr(9) + " AND (DataSource.UserID IS NOT NULL)" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
                    S = S + Chr(9) + " AND (DataSource.UserID IS NOT NULL)" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
                Else
                    'S = S + Chr(9) + " \" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
                    S = S + Chr(9) + " AND (UserID IS NOT NULL)" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
                End If

                Return S
            Else
                'S = S + " AND (UserID = '" + CurrUserID + "'" + Chr(9) + Chr(9) + " /*KEEP 002 */" + vbCrLf
                If SearchCode.Equals("S") Then
                    'S = S + " AND (DataSource.UserID is NOT null " + Chr(9) + Chr(9) + " /*KEEP 002 */" + vbCrLf
                    S = S + " AND (DataSource.UserID is NOT null " + Chr(9) + Chr(9) + " /*KEEP 002 */" + vbCrLf
                Else
                    'S = S + " AND (EMAIL.UserID is NOT null " + Chr(9) + Chr(9) + " /*KEEP 002 */" + vbCrLf
                    S = S + " AND (UserID is NOT null " + Chr(9) + Chr(9) + " /*KEEP 002 */" + vbCrLf
                End If

                S = S + Chr(9) + " or isPublic = 'Y'" + " /*KEEP*/" + vbCrLf
            End If
        End If
        If SearchCode.Equals("S") Or SearchCode.Equals("EMAIL") Then
            If bGlobalSearcher = True Then
                'S = S + " AND (DataSourceOwnerUserID IS NOT NULL" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
                'S = S + Chr(9) + " or isPublic = 'Y'" + " /*KEEP*/" + vbCrLf
                S = S + Chr(9) + "/* This is where the library search would go - you have global rights, think about it.*/" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
                S = S + Chr(9) + " AND (DataSourceOwnerUserID IS NOT NULL)" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
                Return S
            Else
                'S = S + " AND (DataSourceOwnerUserID = '" + CurrUserID + "'" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
                S = S + " AND (DataSourceOwnerUserID IS NOT NULL or isPublic = 'Y'" + " /*KEEP*/" + vbCrLf
            End If
        End If

        's=s+ Chr(9) + " SELECT GroupUsers.GroupName, Library.LibraryName, LibraryUsers.UserID, LibraryItems.SourceGuid" + chr(9) + chr(9) + " /*KEEP*/" + vbCrLf
        S = S + Chr(9) + Chr(9) + " /* GENID:" + LocationID + "*/" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
        If SearchCode.Equals("E") Or SearchCode.Equals("EMAIL") Then
            S = S + Chr(9) + Chr(9) + " or EmailGuid in (" + " /*KEEP*/" + vbCrLf
        Else
            S = S + Chr(9) + Chr(9) + " or SourceGuid in (" + " /*KEEP*/" + vbCrLf
        End If

        S = S + Chr(9) + " SELECT LibraryItems.SourceGuid" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
        S = S + Chr(9) + " FROM   LibraryItems INNER JOIN" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
        S = S + Chr(9) + "        Library ON LibraryItems.LibraryName = Library.LibraryName INNER JOIN" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
        S = S + Chr(9) + "        LibraryUsers ON Library.LibraryName = LibraryUsers.LibraryName INNER JOIN" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
        S = S + Chr(9) + "        GroupLibraryAccess ON Library.LibraryName = GroupLibraryAccess.LibraryName INNER JOIN" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
        S = S + Chr(9) + "        GroupUsers ON GroupLibraryAccess.GroupName = GroupUsers.GroupName" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
        S = S + Chr(9) + " where " + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
        S = S + Chr(9) + "        libraryusers.userid ='" + CurrUserID + "' " + Chr(9) + Chr(9) + " /*KEEP*/   /*ID55*/" + vbCrLf

        S = S + Chr(9) + "UNION " + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
        S = S + Chr(9) + "Select LI.SourceGuid" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
        S = S + Chr(9) + "FROM         LibraryItems AS LI INNER JOIN" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
        S = S + Chr(9) + "             LibraryUsers AS LU ON LI.LibraryName = LU.LibraryName" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
        S = S + Chr(9) + "WHERE     (LU.UserID = '" + CurrUserID + "')" + Chr(9) + Chr(9) + " /*KEEP*/   /*ID56*/" + vbCrLf

        S = S + Chr(9) + "))" + " /*KEEP*/" + vbCrLf

        S = S + Chr(9) + " /* GLOBAL Searcher = " + bGlobalSearcher.ToString + "  */" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf

        Return S

    End Function

    Public Function genLibrarySearch(ByVal CurrUserID As String, ByVal GlobalSearcher As Boolean, ByVal LibraryName As String, ByVal LocationID As String) As String

        Dim S As String = ""
        'S = S + " SELECT GroupUsers.GroupName, Library.LibraryName, LibraryUsers.UserID, LibraryItems.SourceGuid" + chr(9) + chr(9) + " /*KEEP*/" + vbCrLf
        S = S + " /* GENID:" + LocationID + " *KEEP*/" + vbCrLf
        S = S + " SELECT LibraryItems.SourceGuid" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
        S = S + Chr(9) + " FROM   LibraryItems INNER JOIN" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
        S = S + Chr(9) + "        Library ON LibraryItems.LibraryName = Library.LibraryName INNER JOIN" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
        S = S + Chr(9) + "        LibraryUsers ON Library.LibraryName = LibraryUsers.LibraryName INNER JOIN" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
        S = S + Chr(9) + "        GroupLibraryAccess ON Library.LibraryName = GroupLibraryAccess.LibraryName INNER JOIN" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
        S = S + Chr(9) + "        GroupUsers ON GroupLibraryAccess.GroupName = GroupUsers.GroupName" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
        S = S + Chr(9) + " where " + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
        S = S + Chr(9) + "        Library.LibraryName ='" + LibraryName + "' " + Chr(9) + Chr(9) + " /*KEEP*/   /*ID57*/" + vbCrLf

        If GlobalSearcher = False Then
            S = S + Chr(9) + " AND    libraryusers.userid ='" + CurrUserID + "' " + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
        End If
        S = S + Chr(9) + "        /* GLOBAL Searcher = " + GlobalSearcher.ToString + "  */" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf

        S = S + Chr(9) + "UNION " + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf

        S = S + Chr(9) + "Select LI.SourceGuid" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
        S = S + Chr(9) + "FROM   LibraryItems AS LI INNER JOIN" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
        S = S + Chr(9) + "       LibraryUsers AS LU ON LI.LibraryName = LU.LibraryName" + Chr(9) + Chr(9) + " /*KEEP*/   /*ID58*/" + vbCrLf
        If GlobalSearcher = False Then
            S = S + Chr(9) + "WHERE     LI.LibraryName = '" + LibraryName + "'" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
            S = S + Chr(9) + "    AND LU.UserID = '" + CurrUserID + "'" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
        Else
            S = S + Chr(9) + "WHERE     LI.LibraryName = '" + LibraryName + "'" + Chr(9) + Chr(9) + " /*KEEP*/" + vbCrLf
        End If

        Return S

    End Function

    Public Function getStdEmailSearchSql(ByVal ListOfTerms As SortedList(Of String, String)) As String
        Dim S As String = ""

        S = S + "SELECT " + vbCrLf
        S = S + "[SentOn]" + vbCrLf
        S = S + ",[ShortSubj]" + vbCrLf
        S = S + ",[SenderEmailAddress]" + vbCrLf
        S = S + ",[SenderName]" + vbCrLf
        S = S + ",[SentTO]" + vbCrLf
        S = S + ",[Body]" + vbCrLf
        S = S + ",[CC]" + vbCrLf
        S = S + ",[Bcc]" + vbCrLf
        S = S + ",[CreationTime]" + vbCrLf
        S = S + ",[AllRecipients]" + vbCrLf
        S = S + ",[ReceivedByName]" + vbCrLf
        S = S + ",[ReceivedTime]" + vbCrLf
        S = S + ",[MsgSize]" + vbCrLf
        S = S + ",[SUBJECT]" + vbCrLf
        S = S + ",[OriginalFolder]" + vbCrLf
        S = S + ",[EmailGuid], RetentionExpirationDate, isPublic, EMAIL.UserID, SourceTypeCode, NbrAttachments, ' ' as RID, RepoSvrName, 0 as RANK" + vbCrLf
        S = S + "FROM EMAIL" + vbCrLf

        Dim JoinStr As String = genInnerJoin("E", "XXXX")
        JoinStr = "/* " + JoinStr + " 0009 */"
        S += JoinStr

        S = S + "WHERE" + vbCrLf
        S = S + "-- ( CONTAINS(BODY, '@CONTAINS')  " + vbCrLf
        S = S + "-- or CONTAINS(SUBJECT, '@CONTAINS') " + vbCrLf
        S = S + "-- or CONTAINS(Description, '@CONTAINS') " + vbCrLf
        S = S + "-- or CONTAINS(KeyWords, '@CONTAINS') " + vbCrLf
        S = S + "-- or CONTAINS(EmailImage, '@CONTAINS') )" + vbCrLf
        S = S + "-- AND NOT CONTAINS(Body, '@NOTCONTAINS')  " + vbCrLf
        S = S + "-- AND NOT CONTAINS(SUBJECT, '@NOTCONTAINS')  " + vbCrLf
        S = S + "-- AND NOT CONTAINS(Description, '@NOTCONTAINS')  " + vbCrLf
        S = S + "-- AND NOT CONTAINS(KeyWords, '@NOTCONTAINS')  " + vbCrLf
        S = S + "-- AND NOT CONTAINS(EmailImage, '@NOTCONTAINS') )" + vbCrLf
        S = S + "-- and @LibrarySearch" + vbCrLf
        S = S + "-- and SenderEmailAddress like '@SenderEmailAddress'" + vbCrLf
        S = S + "-- and SentTO like '@SentTO' or AllRecipients like '@SentTO'" + vbCrLf
        S = S + "-- and SenderName like @SenderName" + vbCrLf
        S = S + "-- and ReceivedByName like '@ReceivedByName'" + vbCrLf
        S = S + "-- and OriginalFolder like '@OriginalFolder'" + vbCrLf
        S = S + "-- and SUBJECT Like '@SUBJECT' " + vbCrLf
        S = S + "-- and (CC like '@CC' or BCC like '@BCC' or AllRecipients like '@AllRecipients')" + vbCrLf
        S = S + "-- and CreationTime <= '@CreationTimeStart'" + vbCrLf
        S = S + "-- and CreationTime >= '@CreationTimeStart'" + vbCrLf
        S = S + "-- and CreationTime Between '@CreationTimeStart' and '@CreationTimeEnd'" + vbCrLf
        S = S + "-- and SentOn <= '@SentOn'" + vbCrLf
        S = S + "-- and SentOn >= '@SentOn'" + vbCrLf
        S = S + "-- and SentOn Between '@SentOnStart' and '@SentOnEnd'" + vbCrLf
        S = S + "-- and ReceivedTime <= '@ReceivedTime'" + vbCrLf
        S = S + "-- and ReceivedTime <= '@ReceivedTime'" + vbCrLf
        S = S + "-- and ReceivedTime Between '@ReceivedTimeStart' and '@ReceivedTimeEnd'" + vbCrLf
        S = S + "-- and @LibrarySearch" + vbCrLf
        S = S + "-- AND (UserID IS NOT NULL)" + vbCrLf
        S = S + "-- AND (UserID = '@UserID' ) " + vbCrLf
        S = S + "-- Order by @OrderByColumns" + vbCrLf

        Return S
    End Function

    Public Function getEmailSearchWeightedSql(ByRef ListOfSearchTerms As System.Collections.ObjectModel.ObservableCollection(Of DS_SearchTerms)) As String

        Dim S As String = ""
        Dim ckBusiness As Boolean = False
        Dim ckWeighted As Boolean = True
        Dim searchCriteria As String = ""
        Dim IsAboutClause As String = genIsAbout(ckWeighted, ckBusiness, searchCriteria.Trim, False)

        S = S + "SELECT " + vbCrLf
        S = S + "KEY_TBL.RANK, DS.SentOn" + vbCrLf
        S = S + ",DS.ShortSubj" + vbCrLf
        S = S + ",DS.SenderEmailAddress" + vbCrLf
        S = S + ",DS.SenderName" + vbCrLf
        S = S + ",DS.SentTO" + vbCrLf
        S = S + ",DS.Body" + vbCrLf
        S = S + ",DS.CC" + vbCrLf
        S = S + ",DS.Bcc" + vbCrLf
        S = S + ",DS.CreationTime" + vbCrLf
        S = S + ",DS.AllRecipients" + vbCrLf
        S = S + ",DS.ReceivedByName" + vbCrLf
        S = S + ",DS.ReceivedTime" + vbCrLf
        S = S + ",DS.MsgSize" + vbCrLf
        S = S + ",DS.SUBJECT" + vbCrLf
        S = S + ",DS.OriginalFolder" + vbCrLf
        S = S + ",DS.EmailGuid, DS.RetentionExpirationDate, DS.isPublic, DS.UserID, DS.SourceTypeCode, DS.NbrAttachments , ' ' as RID, RepoSvrName" + vbCrLf
        S = S + ",ROW_NUMBER() OVER (ORDER BY SentOn ASC) AS ROWID" + vbCrLf
        S = S + "FROM EMAIL AS DS" + vbCrLf

        Dim JoinStr As String = genInnerJoin("E", "XXXX")
        JoinStr = "/* " + JoinStr + " 0010 */"
        S += JoinStr

        S = S + "INNER JOIN CONTAINSTABLE(EMAIL, *," + vbCrLf
        S = S + "'ISABOUT (@ISABOUT)' ) as KEY_TBL" + vbCrLf
        S = S + "ON DS.EmailGuid = KEY_TBL.[KEY]" + vbCrLf
        S = S + "WHERE" + vbCrLf
        S = S + "( CONTAINS(BODY, '@CONTAINS')  " + vbCrLf
        S = S + "or CONTAINS(SUBJECT, '@CONTAINS') " + vbCrLf
        S = S + "or CONTAINS(Description, '@CONTAINS') " + vbCrLf
        S = S + "or CONTAINS(KeyWords, '@CONTAINS') " + vbCrLf
        S = S + "or CONTAINS(EmailImage, '@CONTAINS') )  " + vbCrLf
        S = S + "-- AND NOT (CONTAINS(BODY, '@NOTCONTAINS')  " + vbCrLf
        S = S + "-- or CONTAINS(SUBJECT, '@NOTCONTAINS') " + vbCrLf
        S = S + "-- or CONTAINS(Description, '@NOTCONTAINS') " + vbCrLf
        S = S + "-- or CONTAINS(KeyWords, '@NOTCONTAINS') " + vbCrLf
        S = S + "-- or CONTAINS(EmailImage, '@NOTCONTAINS') )  " + vbCrLf
        S = S + "-- @LibrarySearch" + vbCrLf
        S = S + "-- and SenderEmailAddress like '@SenderEmailAddress'" + vbCrLf
        S = S + "-- and SentTO like '@SentTO' or AllRecipients like '@SentTO'" + vbCrLf
        S = S + "-- and SenderName like @SenderName" + vbCrLf
        S = S + "-- and ReceivedByName like '@ReceivedByName'" + vbCrLf
        S = S + "-- and OriginalFolder like '@OriginalFolder'" + vbCrLf
        S = S + "-- and SUBJECT Like '@SUBJECT' " + vbCrLf
        S = S + "-- and (CC like '@CC' or BCC like '@BCC' or AllRecipients like '@AllRecipients')" + vbCrLf
        S = S + "-- and CreationTime <= '@CreationTimeStart'" + vbCrLf
        S = S + "-- and CreationTime >= '@CreationTimeStart'" + vbCrLf
        S = S + "-- and CreationTime Between '@CreationTimeStart' and '@CreationTimeEnd'" + vbCrLf
        S = S + "-- and SentOn <= '@SentOn'" + vbCrLf
        S = S + "-- and SentOn >= '@SentOn'" + vbCrLf
        S = S + "-- and SentOn Between '@SentOnStart' and '@SentOnEnd'" + vbCrLf
        S = S + "-- and ReceivedTime <= '@ReceivedTime'" + vbCrLf
        S = S + "-- and ReceivedTime <= '@ReceivedTime'" + vbCrLf
        S = S + "-- and ReceivedTime Between '@ReceivedTimeStart' and '@ReceivedTimeEnd'" + vbCrLf
        S = S + "-- and @LibrarySearch" + vbCrLf
        S = S + "-- AND (UserID IS NOT NULL)" + vbCrLf
        S = S + "-- AND (UserID = '@UserID' ) " + vbCrLf
        S = S + "--and KEY_TBL.RANK >= 0" + vbCrLf
        S = S + "ORDER BY KEY_TBL.RANK DESC" + vbCrLf

        Return S
    End Function

    Public Function getContentSearchSql(ByRef ListOfSearchTerms As System.Collections.ObjectModel.ObservableCollection(Of DS_SearchTerms)) As String
        Dim S As String = " "
        S = S + "SELECT " + vbCrLf
        S = S + "[SentOn]" + vbCrLf
        S = S + ",[ShortSubj]" + vbCrLf
        S = S + ",[SenderEmailAddress]" + vbCrLf
        S = S + ",[SenderName]" + vbCrLf
        S = S + ",[SentTO]" + vbCrLf
        S = S + ",[Body]" + vbCrLf
        S = S + ",[CC]" + vbCrLf
        S = S + ",[Bcc]" + vbCrLf
        S = S + ",[CreationTime]" + vbCrLf
        S = S + ",[AllRecipients]" + vbCrLf
        S = S + ",[ReceivedByName]" + vbCrLf
        S = S + ",[ReceivedTime]" + vbCrLf
        S = S + ",[MsgSize]" + vbCrLf
        S = S + ",[SUBJECT]" + vbCrLf
        S = S + ",[OriginalFolder]" + vbCrLf
        S = S + ",[EmailGuid], RetentionExpirationDate, isPublic, UserID, SourceTypeCode, NbrAttachments, ' ' as RID, RepoSvrName, 0 as RANK" + vbCrLf
        S = S + "FROM EMAIL" + vbCrLf

        Dim JoinStr As String = genInnerJoin("E", "XXXX")
        JoinStr = "/* " + JoinStr + " 0011 */"
        S += JoinStr

        S = S + "WHERE" + vbCrLf
        S = S + "( CONTAINS(BODY, '@CONTAINS')  " + vbCrLf
        S = S + "or CONTAINS(SUBJECT, '@CONTAINS') " + vbCrLf
        S = S + "or CONTAINS(Description, '@CONTAINS') " + vbCrLf
        S = S + "or CONTAINS(KeyWords, '@CONTAINS') " + vbCrLf
        S = S + "or CONTAINS(EmailImage, '@CONTAINS') " + vbCrLf
        S = S + ")  " + vbCrLf
        S = S + "-- AND NOT CONTAINS(Body, '@NOTCONTAINS')  " + vbCrLf
        S = S + "-- AND NOT CONTAINS(SUBJECT, '@NOTCONTAINS')  " + vbCrLf
        S = S + "-- AND NOT CONTAINS(Description, '@NOTCONTAINS')  " + vbCrLf
        S = S + "-- AND NOT CONTAINS(KeyWords, '@NOTCONTAINS')  " + vbCrLf
        S = S + "-- AND NOT CONTAINS(EmailImage, '@NOTCONTAINS')  " + vbCrLf
        S = S + "-- and @LibrarySearch" + vbCrLf
        S = S + "-- and SenderEmailAddress like '@SenderEmailAddress'" + vbCrLf
        S = S + "-- and SentTO like '@SentTO' or AllRecipients like '@SentTO'" + vbCrLf
        S = S + "-- and SenderName like @SenderName" + vbCrLf
        S = S + "-- and ReceivedByName like '@ReceivedByName'" + vbCrLf
        S = S + "-- and OriginalFolder like '@OriginalFolder'" + vbCrLf
        S = S + "-- and SUBJECT Like '@SUBJECT' " + vbCrLf
        S = S + "-- and (CC like '@CC' or BCC like '@BCC' or AllRecipients like '@AllRecipients')" + vbCrLf
        S = S + "-- and CreationTime <= '@CreationTimeStart'" + vbCrLf
        S = S + "-- and CreationTime >= '@CreationTimeStart'" + vbCrLf
        S = S + "-- and CreationTime Between '@CreationTimeStart' and '@CreationTimeEnd'" + vbCrLf
        S = S + "-- and SentOn <= '@SentOn'" + vbCrLf
        S = S + "-- and SentOn >= '@SentOn'" + vbCrLf
        S = S + "-- and SentOn Between '@SentOnStart' and '@SentOnEnd'" + vbCrLf
        S = S + "-- and ReceivedTime <= '@ReceivedTime'" + vbCrLf
        S = S + "-- and ReceivedTime <= '@ReceivedTime'" + vbCrLf
        S = S + "-- and ReceivedTime Between '@ReceivedTimeStart' and '@ReceivedTimeEnd'" + vbCrLf
        S = S + "-- and @LibrarySearch" + vbCrLf
        S = S + "-- AND (UserID IS NOT NULL)" + vbCrLf
        S = S + "-- AND (UserID = '@UserID' ) " + vbCrLf
        S = S + "-- Order by @OrderByColumns" + vbCrLf

        Return S
    End Function

    ''' <summary>
    ''' Gets the content search weighted SQL.
    ''' </summary>
    ''' <param name="ListOfSearchTerms">The list of search terms.</param>
    ''' <returns></returns>
    Public Function getContentSearchWeightedSql(ByRef ListOfSearchTerms As System.Collections.ObjectModel.ObservableCollection(Of DS_SearchTerms)) As String
        Dim S As String = " "

        Return S
    End Function

    ''' <summary>
    ''' Gens the owner search SQL.
    ''' </summary>
    ''' <param name="SearchParmList">The search parm list.</param>
    ''' <param name="SecureID">The secure ID.</param>
    ''' <returns></returns>
    Function genOwnerFilterSql(ByVal SearchParmList As SortedList(Of String, String), ByRef SecureID As Integer) As String

        '***************************************************************************************************
        '***** Load the passed in parameters
        '***************************************************************************************************
        Dim UID As String = ""
        Dim bAdmin As Boolean = False
        Dim bSuperAdmin As Boolean = False
        Dim bGlobalSearcher As Boolean = False
        Dim CurrUserGuidID As String = ""
        Dim CurrLoginID As String = ""
        Dim txtSelDir As String = ""
        Dim cbLibrary As String = ""
        Dim nbrWeightMin As Integer = -1
        Dim rbAll As Boolean = False
        Dim rbContent As Boolean = False
        Dim rbEmails As Boolean = False
        Dim ckMyContent As Boolean = False
        Dim ckMasterOnly As Boolean = False
        Dim ckWeights As Boolean = False
        Dim MinWeight As Integer = 0
        Dim bIncludeAllLibs As Boolean = True
        Dim ckBusiness As Boolean = False
        Dim LibraryName As String = ""
        Dim ckLimitToLib As Boolean = False

        Dim content_ckDays As Boolean = False
        Dim content_nbrDays As Integer = Nothing
        Dim content_cbEvalCreateTime As String = ""
        Dim content_cbEvalWriteTime As String = ""
        Dim content_dtCreateDateStart As Date = Nothing
        Dim content_dtCreateDateEnd As Date = Nothing
        Dim content_dtLastWriteStart As Date = Nothing
        Dim content_dtLastWriteEnd As Date = Nothing
        Dim content_txtcbFileTypes As String = ""
        Dim content_txtFileName As String = ""
        Dim content_txtDirectory As String = ""
        Dim content_txtMetaSearch1 As String = ""
        Dim content_txtMetaSearch2 As String = ""
        Dim content_txtdtCreateDateStart As Date = Nothing
        Dim content_txtdtCreateDateEnd As Date = Nothing
        Dim content_txtdtLastWriteStart As Date = Nothing
        Dim content_cbMeta1 As String = ""
        Dim content_cbMeta2 As String = ""

        UTIL.getSearchParmList("content.ckDays", content_ckDays, SearchParmList)
        UTIL.getSearchParmList("content.nbrDays", content_nbrDays, SearchParmList)
        UTIL.getSearchParmList("content.cbEvalCreateTime", content_cbEvalCreateTime, SearchParmList)
        UTIL.getSearchParmList("content.cbEvalWriteTime", content_cbEvalWriteTime, SearchParmList)
        UTIL.getSearchParmList("content.dtCreateDateStart", content_dtCreateDateStart, SearchParmList)
        UTIL.getSearchParmList("content.dtCreateDateEnd", content_dtCreateDateEnd, SearchParmList)
        UTIL.getSearchParmList("content.dtLastWriteStart", content_dtLastWriteStart, SearchParmList)
        UTIL.getSearchParmList("content.dtLastWriteEnd", content_dtLastWriteEnd, SearchParmList)
        UTIL.getSearchParmList("content.txtFileTypes", content_txtcbFileTypes, SearchParmList)
        UTIL.getSearchParmList("content.txtFileName", content_txtFileName, SearchParmList)
        UTIL.getSearchParmList("content.txtDirectory", content_txtDirectory, SearchParmList)
        UTIL.getSearchParmList("content.txtMetaSearch1", content_txtMetaSearch1, SearchParmList)
        UTIL.getSearchParmList("content.txtMetaSearch2", content_txtMetaSearch2, SearchParmList)
        UTIL.getSearchParmList("content.txtdtCreateDateStart", content_txtdtCreateDateStart, SearchParmList)
        UTIL.getSearchParmList("content.txtdtCreateDateEnd", content_txtdtCreateDateEnd, SearchParmList)
        UTIL.getSearchParmList("content.txtdtLastWriteStart", content_txtdtLastWriteStart, SearchParmList)
        UTIL.getSearchParmList("content.cbMeta1", content_cbMeta1, SearchParmList)
        UTIL.getSearchParmList("content.cbMeta2", content_cbMeta2, SearchParmList)

        UTIL.getSearchParmList("ckMasterOnly", ckMasterOnly, SearchParmList)
        UTIL.getSearchParmList("ckWeights", ckWeights, SearchParmList)
        UTIL.getSearchParmList("ckMasterOnly", ckMasterOnly, SearchParmList)
        UTIL.getSearchParmList("ckMyContent", ckMyContent, SearchParmList)
        UTIL.getSearchParmList("ckLimitToLib", ckLimitToLib, SearchParmList)
        UTIL.getSearchParmList("rbEmails", rbEmails, SearchParmList)
        UTIL.getSearchParmList("rbContent", rbContent, SearchParmList)
        UTIL.getSearchParmList("rbAll", rbAll, SearchParmList)
        UTIL.getSearchParmList("nbrWeightMin", nbrWeightMin, SearchParmList)
        UTIL.getSearchParmList("cbLibrary", cbLibrary, SearchParmList)
        UTIL.getSearchParmList("txtSelDir", txtSelDir, SearchParmList)
        UTIL.getSearchParmList("CurrLoginID", CurrLoginID, SearchParmList)
        UTIL.getSearchParmList("CurrUserGuidID", CurrUserGuidID, SearchParmList)
        UTIL.getSearchParmList("isSuperAdmin", bSuperAdmin, SearchParmList)
        UTIL.getSearchParmList("isAdmin", bAdmin, SearchParmList)
        UTIL.getSearchParmList("isGlobalSearcher", bGlobalSearcher, SearchParmList)
        UTIL.getSearchParmList("UID", CurrUserGuidID, SearchParmList)
        'UTIL.getSearchParmList("txtThesaurus", txtThesaurus, SearchParmList)
        'UTIL.getSearchParmList("cbThesaurusText", cbThesaurusText, SearchParmList)

        UTIL.getSearchParmList("LibraryName", LibraryName, SearchParmList)
        UTIL.getSearchParmList("MinWeight", MinWeight, SearchParmList)
        UTIL.getSearchParmList("bIncludeAllLibs", bIncludeAllLibs, SearchParmList)

        'UTIL.getSearchParmList("txtSearch", SearchString, SearchParmList)
        'UTIL.getSearchParmList("ckLimitToExisting", ckLimitToExisting, SearchParmList)
        UTIL.getSearchParmList("getCountOnly", getCountOnly, SearchParmList)
        UTIL.getSearchParmList("UseExistingRecordsOnly", UseExistingRecordsOnly, SearchParmList)
        UTIL.getSearchParmList("ckWeights", ckWeights, SearchParmList)
        UTIL.getSearchParmList("ckMasterOnly", ckMasterOnly, SearchParmList)
        UTIL.getSearchParmList("ckMyContent", ckMyContent, SearchParmList)
        UTIL.getSearchParmList("ckBusiness", ckBusiness, SearchParmList)
        '***************************************************************************************************

        Dim UserSql As String = ""
        LibraryName = UTIL.RemoveSingleQuotes(LibraryName)
        If bAdmin Or bGlobalSearcher Then
            '** ECM WhereClause
            If ckLimitToLib = True Then
                'UserSql = UserSql + " AND SourceGuid in (SELECT [SourceGuid] FROM [LibraryItems] where LibraryName = '" + LibraryName$ + "')" + vbCrLf
                '** DO NOT PUT vbcrlf at the end of the below lines. That will cause problems in inserting PAGING.
                UserSql = UserSql + " AND SourceGuid in (" + genLibrarySearch(CurrUserGuidID, True, LibraryName, "Gen@13") + ")"
            Else
                If ckMyContent = True Then
                    UserSql = UserSql + " and ( DataSourceOwnerUserID = '" + CurrUserGuidID + "') " + vbCrLf
                Else
                    Dim gSearcher As Boolean = False
                    If bAdmin Or bGlobalSearcher Then
                        gSearcher = True
                    End If
                    Dim IncludeLibsSql As String = genLibrarySearch(CurrUserGuidID, True, gSearcher, "@Gen31")
                    UserSql = UserSql + IncludeLibsSql
                End If
                If ckMasterOnly Then
                    UserSql = UserSql + " and ( isMaster = 'Y' )       /*KEEP*/" + vbCrLf
                End If
                If content_ckDays Then
                    UserSql = UserSql + DocSearchCreatedWithinLastXDays(content_ckDays, content_nbrDays.ToString, True) + vbCrLf
                End If
            End If
        Else
            If ckLimitToLib = True Then
                Dim gSearcher As Boolean = False
                If bAdmin Or bGlobalSearcher Then
                    gSearcher = True
                End If
                UserSql = " AND SourceGuid in (" + genLibrarySearch(CurrUserGuidID, gSearcher, LibraryName, "Gen@01") + ")"
            Else
                'UserSql = UserSql + " and ( DataSourceOwnerUserID is not null OR isPublic = 'Y' )" + vbCrLf
                '** ECM WhereClause
                If ckMyContent = True Then
                    UserSql = UserSql + " and ( DataSourceOwnerUserID = '" + CurrUserGuidID + "') " + vbCrLf
                Else
                    Dim gSearcher As Boolean = False
                    If bAdmin Or bGlobalSearcher Then
                        gSearcher = True
                    End If
                    Dim IncludeLibsSql As String = genLibrarySearch(CurrUserGuidID, True, gSearcher, "@Gen32")
                    UserSql = UserSql + IncludeLibsSql
                End If

                If ckMasterOnly Then
                    UserSql = UserSql + " and ( isMaster = 'Y' )      /*KEEP*/" + vbCrLf
                End If
                If content_ckDays Then
                    UserSql = UserSql + DocSearchCreatedWithinLastXDays(content_ckDays, content_nbrDays.ToString, True) + vbCrLf
                End If
            End If
        End If
        Return UserSql
    End Function

    Function getContentTblCols(ByRef SecureID As Integer, iMaxRows As Integer, ByVal ckWeights As Boolean, ByVal UserID As String, isAdmin As Boolean, isPowerSearcher As Boolean) As String
        Dim DocsSql As String = ""

        If ckWeights Then
            If iMaxRows > 0 Then
                If iMaxRows > 0 Then
                    DocsSql = " SELECT TOP " + iMaxRows.tostring
                Else
                    DocsSql = " SELECT "
                End If
            Else
                DocsSql = " SELECT "
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
            DocsSql += vbTab + ",DS.DataSourceOwnerUserID, DS.FileDirectory, DS.RetentionExpirationDate, DS.isMaster, DS.StructuredData, DS.RepoSvrName, DS.Description, DS.RssLinkFlg, DS.isWebPage  " + vbCrLf
            DocsSql += "FROM DataSource as DS " + vbCrLf

            If (Not isPowerSearcher And Not isAdmin) Then
                Dim JoinStr As String = genInnerJoin("C", UserID)
                JoinStr += Chr(9) + Chr(9) + " /* C0012 */"
                DocsSql += JoinStr
            End If

        Else
            If iMaxRows > 0 Then
                If iMaxRows > 0 Then
                    DocsSql = " SELECT TOP " + iMaxRows.tostring
                Else
                    DocsSql = " SELECT "
                End If
            Else
                DocsSql = " SELECT "
            End If
            DocsSql += vbTab + "[SourceName] 	" + vbCrLf
            DocsSql += vbTab + ",[CreateDate] " + vbCrLf
            DocsSql += vbTab + ",[VersionNbr] 	" + vbCrLf
            DocsSql += vbTab + ",[LastAccessDate] " + vbCrLf
            DocsSql += vbTab + ",[FileLength] " + vbCrLf
            DocsSql += vbTab + ",[LastWriteTime] " + vbCrLf
            DocsSql += vbTab + ",[OriginalFileType] 		" + vbCrLf
            DocsSql += vbTab + ",[isPublic] " + vbCrLf
            DocsSql += vbTab + ",[FQN] " + vbCrLf
            DocsSql += vbTab + ",[SourceGuid] " + vbCrLf
            DocsSql += vbTab + ",[DataSourceOwnerUserID], FileDirectory, StructuredData, RepoSvrName, Description, RssLinkFlg, isWebPage, RetentionExpirationDate  " + vbCrLf
            DocsSql += "FROM DataSource " + vbCrLf

            If (Not isPowerSearcher And Not isAdmin) Then
                Dim JoinStr As String = genInnerJoin("C", UserID)
                JoinStr += Chr(9) + Chr(9) + " /* C0013 */"
                DocsSql += JoinStr
            End If

        End If

        Return DocsSql
    End Function

    Function genContainsClause(ByVal SearchParmList As SortedList(Of String, String), ByRef SecureID As Integer, ByVal EmailOrContent As String) As String

        '***************************************************************************************************
        '***** Load the passed in parameters
        '***************************************************************************************************
        Dim bAdmin As Boolean = False
        Dim bSuperAdmin As Boolean = False
        Dim bGlobalSearcher As Boolean = False
        Dim CurrUserGuidID As String = ""
        Dim CurrLoginID As String = ""
        Dim txtSelDir As String = ""
        Dim cbLibrary As String = ""
        Dim nbrWeightMin As Integer = -1
        Dim rbAll As Boolean = False
        Dim rbContent As Boolean = False
        Dim rbEmails As Boolean = False
        Dim ckMyContent As Boolean = False
        Dim ckMasterOnly As Boolean = False
        Dim ckWeights As Boolean = False
        Dim MinWeight As Integer = 0
        Dim bIncludeAllLibs As Boolean = True
        Dim ckBusiness As Boolean = False
        Dim ckLimitToLib As Boolean = False

        Dim UID As String = ""
        Dim LibraryName As String = ""
        Dim txtSearch As String = ""
        Dim ckLimitToExisting As Boolean = Nothing

        Dim content_ckDays As Boolean = False
        Dim content_nbrDays As Integer = Nothing
        Dim content_cbEvalCreateTime As String = ""
        Dim content_cbEvalWriteTime As String = ""
        Dim content_dtCreateDateStart As Date = Nothing
        Dim content_dtCreateDateEnd As Date = Nothing
        Dim content_dtLastWriteStart As Date = Nothing
        Dim content_dtLastWriteEnd As Date = Nothing
        Dim content_txtcbFileTypes As String = ""
        Dim content_txtFileName As String = ""
        Dim content_txtDirectory As String = ""
        Dim content_txtMetaSearch1 As String = ""
        Dim content_txtMetaSearch2 As String = ""
        Dim content_txtdtCreateDateStart As Date = Nothing
        Dim content_txtdtCreateDateEnd As Date = Nothing
        Dim content_txtdtLastWriteStart As Date = Nothing
        Dim content_cbMeta1 As String = ""
        Dim content_cbMeta2 As String = ""

        Dim txtThesaurus As String = ""
        Dim cbThesaurusText As String = ""

        UTIL.getSearchParmList("content.ckDays", content_ckDays, SearchParmList)
        UTIL.getSearchParmList("content.nbrDays", content_nbrDays, SearchParmList)
        UTIL.getSearchParmList("content.cbEvalCreateTime", content_cbEvalCreateTime, SearchParmList)
        UTIL.getSearchParmList("content.cbEvalWriteTime", content_cbEvalWriteTime, SearchParmList)
        UTIL.getSearchParmList("content.dtCreateDateStart", content_dtCreateDateStart, SearchParmList)
        UTIL.getSearchParmList("content.dtCreateDateEnd", content_dtCreateDateEnd, SearchParmList)
        UTIL.getSearchParmList("content.dtLastWriteStart", content_dtLastWriteStart, SearchParmList)
        UTIL.getSearchParmList("content.dtLastWriteEnd", content_dtLastWriteEnd, SearchParmList)
        UTIL.getSearchParmList("content.txtFileTypes", content_txtcbFileTypes, SearchParmList)
        UTIL.getSearchParmList("content.txtFileName", content_txtFileName, SearchParmList)
        UTIL.getSearchParmList("content.txtDirectory", content_txtDirectory, SearchParmList)
        UTIL.getSearchParmList("content.txtMetaSearch1", content_txtMetaSearch1, SearchParmList)
        UTIL.getSearchParmList("content.txtMetaSearch2", content_txtMetaSearch2, SearchParmList)
        UTIL.getSearchParmList("content.txtdtCreateDateStart", content_txtdtCreateDateStart, SearchParmList)
        UTIL.getSearchParmList("content.txtdtCreateDateEnd", content_txtdtCreateDateEnd, SearchParmList)
        UTIL.getSearchParmList("content.txtdtLastWriteStart", content_txtdtLastWriteStart, SearchParmList)
        UTIL.getSearchParmList("content.cbMeta1", content_cbMeta1, SearchParmList)
        UTIL.getSearchParmList("content.cbMeta2", content_cbMeta2, SearchParmList)

        UTIL.getSearchParmList("ckWeights", ckWeights, SearchParmList)
        UTIL.getSearchParmList("ckMasterOnly", ckMasterOnly, SearchParmList)
        UTIL.getSearchParmList("ckMyContent", ckMyContent, SearchParmList)
        UTIL.getSearchParmList("ckLimitToLib", ckLimitToLib, SearchParmList)
        UTIL.getSearchParmList("rbEmails", rbEmails, SearchParmList)
        UTIL.getSearchParmList("rbContent", rbContent, SearchParmList)
        UTIL.getSearchParmList("rbAll", rbAll, SearchParmList)
        UTIL.getSearchParmList("nbrWeightMin", nbrWeightMin, SearchParmList)
        UTIL.getSearchParmList("cbLibrary", cbLibrary, SearchParmList)
        UTIL.getSearchParmList("txtSelDir", txtSelDir, SearchParmList)
        UTIL.getSearchParmList("CurrLoginID", CurrLoginID, SearchParmList)
        UTIL.getSearchParmList("CurrUserGuidID", CurrUserGuidID, SearchParmList)
        UTIL.getSearchParmList("isSuperAdmin", bSuperAdmin, SearchParmList)
        UTIL.getSearchParmList("isAdmin", bAdmin, SearchParmList)
        UTIL.getSearchParmList("isGlobalSearcher", bGlobalSearcher, SearchParmList)
        UTIL.getSearchParmList("UID", CurrUserGuidID, SearchParmList)
        UTIL.getSearchParmList("txtThesaurus", txtThesaurus, SearchParmList)
        UTIL.getSearchParmList("cbThesaurusText", cbThesaurusText, SearchParmList)

        UTIL.getSearchParmList("LibraryName", LibraryName, SearchParmList)
        UTIL.getSearchParmList("MinWeight", MinWeight, SearchParmList)
        UTIL.getSearchParmList("bIncludeAllLibs", bIncludeAllLibs, SearchParmList)

        UTIL.getSearchParmList("txtSearch", txtSearch, SearchParmList)
        UTIL.getSearchParmList("ckLimitToExisting", ckLimitToExisting, SearchParmList)
        UTIL.getSearchParmList("getCountOnly", getCountOnly, SearchParmList)
        UTIL.getSearchParmList("UseExistingRecordsOnly", UseExistingRecordsOnly, SearchParmList)
        UTIL.getSearchParmList("ckWeights", ckWeights, SearchParmList)
        UTIL.getSearchParmList("ckMasterOnly", ckMasterOnly, SearchParmList)
        UTIL.getSearchParmList("ckMyContent", ckMyContent, SearchParmList)
        UTIL.getSearchParmList("ckBusiness", ckBusiness, SearchParmList)
        '***************************************************************************************************

        Dim useFreetext As Boolean = ckBusiness
        Dim WhereClause As String = ""
        Dim S As String = ""
        'Dim ThesaurusList As New ArrayList
        Dim ThesaurusWords As New ArrayList
        Dim ContainsClause As String = ""
        Dim isValidContainsClause As Boolean = False
        Dim lParens As Integer = 0
        Dim rParens As Integer = 0

        If txtSearch.Length = 0 Then
            '** NO Search criteria was specified send back something that will return everything
            If EmailOrContent.Equals("EMAIL") Then
                WhereClause = " UserID is not null "
            Else
                WhereClause = " DataSourceOwnerUserID is not null "
            End If
            Return WhereClause
        End If

        If ckWeights Then

            If txtSearch.Length = 0 Then
                If bAdmin Or bGlobalSearcher = True Then
                    ContainsClause$ = " DataSourceOwnerUserID is not null "
                Else
                    Dim JoinStr As String = ""
                    If EmailOrContent.ToUpper.Equals("EMAIL") Then
                        JoinStr = genInnerJoin("E", UID)
                    Else
                        JoinStr = genInnerJoin("C", UID)
                    End If

                    ContainsClause$ = " DataSourceOwnerUserID = '" + UID + "' "
                End If

            Else
                ContainsClause$ = buildContainsSyntax(SecureID, txtSearch, ThesaurusWords)
            End If

            isValidContainsClause = ValidateContainsList(SecureID, ContainsClause)

            If EmailOrContent.ToUpper.Equals("EMAIL") Then
                If useFreetext = True Then
                    '** This is FREETEXT searching, remove noise words
                    Me.RemoveFreetextStopWords(SecureID, txtSearch)
                    If txtSearch.Length > 0 Or txtThesaurus.Trim.Length > 0 Then
                        If isValidContainsClause Then
                            '(Body, Description, KeyWords, Subject, Attachment, Ocrtext)
                            WhereClause += " ( FREETEXT ((Body, SUBJECT, KeyWords, Description), '"
                            S = txtSearch
                            WhereClause += buildContainsSyntax(SecureID, S, ThesaurusWords)
                            WhereClause += "') "
                            rParens += 1
                        End If

                        If txtThesaurus.Trim.Length > 0 Then
                            Dim ExpandedWordList As String = PopulateThesaurusList(SecureID, ThesaurusList, ThesaurusWords, txtThesaurus, cbThesaurusText)
                            If ExpandedWordList.Trim.Length > 0 Then
                                WhereClause += vbCrLf + Chr(9) + cbThesaurusText + " FREETEXT ((Body, SUBJECT, KeyWords, Description), '" + ExpandedWordList
                                WhereClause += "')" + vbCrLf + "/* 0A1 */ " + vbCrLf
                                rParens += 1
                            End If
                        End If

                        '** 5/29/2008 by WDM now, get the SUBJECT searched too.
                        If isValidContainsClause Then
                            WhereClause += " or FREETEXT ((Body, SUBJECT, KeyWords, Description), '"
                            S = txtSearch
                            WhereClause += buildContainsSyntax(SecureID, S, ThesaurusWords)
                            WhereClause += "') " + vbCrLf + " /* 00 */ " + vbCrLf
                            rParens += 1
                        End If

                        If txtThesaurus.Trim.Length > 0 Then
                            Dim ExpandedWordList As String = PopulateThesaurusList(SecureID, ThesaurusList, ThesaurusWords, txtThesaurus, cbThesaurusText)
                            If ExpandedWordList.Trim.Length > 0 Then
                                WhereClause += vbCrLf + Chr(9) + " OR FREETEXT ((Body, SUBJECT, KeyWords, Description), '" + ExpandedWordList
                                WhereClause += "') "
                                rParens += 1
                            End If
                        End If
                        WhereClause += ")" + vbCrLf + "  /* #2 */" + vbCrLf
                    End If
                Else
                    'Processing a weighted set of documents
                    lParens = 0
                    If txtSearch.Length > 0 Or txtThesaurus.Trim.Length > 0 Then
                        WhereClause += " ( CONTAINS(BODY, '"
                        S = txtSearch
                        WhereClause += buildContainsSyntax(SecureID, S, ThesaurusWords)
                        WhereClause += "')   /*YY00a*/ " + vbCrLf

                        lParens = lParens + 1

                        If txtThesaurus.Trim.Length > 0 Then
                            Dim ExpandedWordList As String = PopulateThesaurusList(SecureID, ThesaurusList, ThesaurusWords, txtThesaurus, cbThesaurusText)
                            If ExpandedWordList.Trim.Length > 0 Then
                                WhereClause = WhereClause + vbCrLf
                                WhereClause += vbCrLf + Chr(9) + cbThesaurusText + " (CONTAINS (body, '" + ExpandedWordList
                                WhereClause += "')   /*YY00*/" + vbCrLf
                                lParens = lParens + 1
                            End If
                        End If

                        WhereClause += " or CONTAINS(EmailImage, '"
                        S = txtSearch
                        WhereClause += buildContainsSyntax(SecureID, S, ThesaurusWords)
                        WhereClause += "')   /*XX01*/" + vbCrLf

                        WhereClause += " or CONTAINS(SUBJECT, '"
                        S = txtSearch
                        WhereClause += buildContainsSyntax(SecureID, S, ThesaurusWords)
                        WhereClause += "')   /*XX02*/" + vbCrLf

                        If txtThesaurus.Trim.Length > 0 Then
                            Dim ExpandedWordList As String = PopulateThesaurusList(SecureID, ThesaurusList, ThesaurusWords, txtThesaurus, cbThesaurusText)
                            If ExpandedWordList.Trim.Length > 0 Then
                                WhereClause = WhereClause + vbCrLf
                                WhereClause += vbCrLf + Chr(9) + cbThesaurusText + " (CONTAINS (subject, '" + getThesaurusWords(SecureID, ThesaurusList, ThesaurusWords)
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
                    If txtSearch.Length > 0 Or txtThesaurus.Trim.Length > 0 Then
                        Me.RemoveFreetextStopWords(SecureID, txtSearch)
                        Me.RemoveFreetextStopWords(SecureID, txtThesaurus)
                        'WhereClause += " FREETEXT (SourceImage, '"
                        'WhereClause += " FREETEXT (DataSource.*, '"
                        WhereClause += " FREETEXT ((Description, KeyWords, Notes, SourceImage, SourceName), '"
                        S = txtSearch
                        WhereClause += buildContainsSyntax(SecureID, S, ThesaurusWords)
                        WhereClause += "')"

                        If txtThesaurus.Trim.Length > 0 Then
                            Dim ExpandedWordList As String = PopulateThesaurusList(SecureID, ThesaurusList, ThesaurusWords, txtThesaurus, cbThesaurusText)
                            If ExpandedWordList.Trim.Length > 0 Then
                                'WhereClause += vbCrLf + Chr(9) + cbThesaurusText + " freetext (SourceImage, '" + ExpandedWordList
                                'WhereClause += vbCrLf + Chr(9) + cbThesaurusText + " freetext (DataSource.*, '" + ExpandedWordList
                                WhereClause += vbCrLf + Chr(9) + cbThesaurusText + " freetext ((Description, KeyWords, Notes, SourceImage, SourceName), '" + ExpandedWordList
                                WhereClause += "')" + vbCrLf + "/* 0A2 */ " + vbCrLf
                                rParens += 1
                            End If
                        End If
                    End If
                Else
                    If txtSearch.Length > 0 Or txtThesaurus.Trim.Length > 0 Then
                        WhereClause += " (CONTAINS(SourceImage, '"
                        S = txtSearch
                        WhereClause += buildContainsSyntax(SecureID, S, ThesaurusWords)
                        WhereClause += "'))     /*XX03*/ "

                        If txtThesaurus.Trim.Length > 0 Then
                            Dim ExpandedWordList As String = PopulateThesaurusList(SecureID, ThesaurusList, ThesaurusWords, txtThesaurus, cbThesaurusText)
                            If ExpandedWordList.Trim.Length > 0 Then
                                WhereClause += vbCrLf + Chr(9) + cbThesaurusText + " CONTAINS (SourceImage, '" + ExpandedWordList
                                WhereClause += "')" + vbCrLf + "/* 0A3 */ " + vbCrLf
                                rParens += 1
                            End If
                        End If
                    End If
                End If
            End If
        Else
            '** No weightings used in this query
            If txtSearch.Length = 0 Then
                If bAdmin Or bGlobalSearcher = True Then
                    ContainsClause$ = " DataSourceOwnerUserID is not null "
                Else

                    ContainsClause$ = " DataSourceOwnerUserID = '" + UID + "' "
                    Dim JoinStr As String = genInnerJoin("C", "XXXX")
                    JoinStr = "/* " + JoinStr + " 0014 */"
                    ContainsClause$ += JoinStr

                End If
            ElseIf useFreetext = True Then
                If txtSearch.Length > 0 Or txtThesaurus.Trim.Length > 0 Then
                    Me.RemoveFreetextStopWords(SecureID, txtSearch)
                    Me.RemoveFreetextStopWords(SecureID, txtThesaurus)

                    WhereClause += " FREETEXT ((Body, SUBJECT, KeyWords, Description), '"
                    S = txtSearch
                    WhereClause += buildContainsSyntax(SecureID, S, ThesaurusWords)
                    WhereClause += "')" + vbCrLf

                    If txtThesaurus.Trim.Length > 0 Then
                        Dim ExpandedWordList As String = PopulateThesaurusList(SecureID, ThesaurusList, ThesaurusWords, txtThesaurus, cbThesaurusText)
                        If ExpandedWordList.Trim.Length > 0 Then
                            WhereClause += vbCrLf + Chr(9) + cbThesaurusText + " FREETEXT ((Body, SUBJECT, KeyWords, Description), '" + ExpandedWordList
                            WhereClause += "')" + vbCrLf + "/* 0A4 */ " + vbCrLf
                            rParens += 1
                        End If
                    End If
                    'WhereClause += ")  /* XX  Final Quotes */"
                End If
            Else
                If txtSearch.Length > 0 Or txtThesaurus.Trim.Length > 0 Then
                    If EmailOrContent.Equals("EMAIL") Then
                        'WhereClause += " CONTAINS(EMAIL.*, '"
                        WhereClause += " CONTAINS(EMAIL.*, '"
                    Else
                        'WhereClause += " CONTAINS(DataSource.*, '"
                        WhereClause += " CONTAINS(DataSource.*, '"
                    End If

                    S = txtSearch
                    WhereClause += buildContainsSyntax(SecureID, S, ThesaurusWords)
                    WhereClause += "')     /*XX04*/ "

                    If txtThesaurus.Trim.Length > 0 Then
                        Dim ExpandedWordList As String = PopulateThesaurusList(SecureID, ThesaurusList, ThesaurusWords, txtThesaurus, cbThesaurusText)
                        If ExpandedWordList.Trim.Length > 0 Then
                            WhereClause += vbCrLf + Chr(9) + cbThesaurusText + " CONTAINS (*, '" + ExpandedWordList
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
        Return WhereClause
    End Function

    Function genIsAbout(ByRef SecureID As Integer, ByVal ckWeights As Boolean, ByVal useFreetext As Boolean, ByVal SearchText As String, ByVal isEmailSearch As Boolean) As String
        If ckWeights = False Then
            Return ""
        End If
        Dim isAboutClause As String = ""
        Dim SearchStr$ = SearchText
        Dim CorrectedSearchClause As String = CleanIsAboutSearchText(SecureID, SearchText)
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
    ''' generates the SQL required to do a content search.
    ''' Generate SQL
    ''' </summary>
    ''' <param name="SearchParmList">The search parm list.</param>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns></returns>
    Public Function GenContentSearchSQL(ByVal SearchParmList As SortedList(Of String, String), ByRef SecureID As Integer) As String

        '***************************************************************************************************
        '***** Load the passed in parameters
        '***************************************************************************************************
        Dim UID As String = ""
        Dim bAdmin As Boolean = False
        Dim ckLimitToLib As Boolean = False
        Dim LibraryName As String = ""

        Dim txtThesaurus As String = ""
        Dim cbThesaurusText As String = ""
        Dim txtSearch As String = ""
        Dim ckLimitToExisting As Boolean = Nothing
        Dim ckWeights As Boolean = Nothing

        Dim bSuperAdmin As Boolean = False
        Dim bGlobalSearcher As Boolean = False
        Dim CurrUserGuidID As String = ""
        Dim CurrLoginID As String = ""
        Dim txtSelDir As String = ""
        Dim cbLibrary As String = ""
        Dim nbrWeightMin As Integer = -1
        Dim rbAll As Boolean = False
        Dim rbContent As Boolean = False
        Dim rbEmails As Boolean = False
        Dim ckMyContent As Boolean = False
        Dim ckMasterOnly As Boolean = False
        Dim MinWeight As Integer = 0
        Dim bIncludeAllLibs As Boolean = True
        Dim ckBusiness As Boolean = False

        Dim content_ckDays As Boolean = False
        Dim content_nbrDays As Integer = Nothing
        Dim content_cbEvalCreateTime As String = ""
        Dim content_cbEvalWriteTime As String = ""
        Dim content_dtCreateDateStart As Date = Nothing
        Dim content_dtCreateDateEnd As Date = Nothing
        Dim content_dtLastWriteStart As Date = Nothing
        Dim content_dtLastWriteEnd As Date = Nothing
        Dim content_txtcbFileTypes As String = ""
        Dim content_txtFileName As String = ""
        Dim content_txtDirectory As String = ""
        Dim content_txtMetaSearch1 As String = ""
        Dim content_txtMetaSearch2 As String = ""
        Dim content_txtdtCreateDateStart As Date = Nothing
        Dim content_txtdtCreateDateEnd As Date = Nothing
        Dim content_txtdtLastWriteStart As Date = Nothing
        Dim content_cbMeta1 As String = ""
        Dim content_cbMeta2 As String = ""

        UTIL.getSearchParmList("content.ckDays", content_ckDays, SearchParmList)
        UTIL.getSearchParmList("content.nbrDays", content_nbrDays, SearchParmList)
        UTIL.getSearchParmList("content.cbEvalCreateTime", content_cbEvalCreateTime, SearchParmList)
        UTIL.getSearchParmList("content.cbEvalWriteTime", content_cbEvalWriteTime, SearchParmList)
        UTIL.getSearchParmList("content.dtCreateDateStart", content_dtCreateDateStart, SearchParmList)
        UTIL.getSearchParmList("content.dtCreateDateEnd", content_dtCreateDateEnd, SearchParmList)
        UTIL.getSearchParmList("content.dtLastWriteStart", content_dtLastWriteStart, SearchParmList)
        UTIL.getSearchParmList("content.dtLastWriteEnd", content_dtLastWriteEnd, SearchParmList)
        UTIL.getSearchParmList("content.txtFileTypes", content_txtcbFileTypes, SearchParmList)
        UTIL.getSearchParmList("content.txtFileName", content_txtFileName, SearchParmList)
        UTIL.getSearchParmList("content.txtDirectory", content_txtDirectory, SearchParmList)
        UTIL.getSearchParmList("content.txtMetaSearch1", content_txtMetaSearch1, SearchParmList)
        UTIL.getSearchParmList("content.txtMetaSearch2", content_txtMetaSearch2, SearchParmList)
        UTIL.getSearchParmList("content.txtdtCreateDateStart", content_txtdtCreateDateStart, SearchParmList)
        UTIL.getSearchParmList("content.txtdtCreateDateEnd", content_txtdtCreateDateEnd, SearchParmList)
        UTIL.getSearchParmList("content.txtdtLastWriteStart", content_txtdtLastWriteStart, SearchParmList)
        UTIL.getSearchParmList("content.cbMeta1", content_cbMeta1, SearchParmList)
        UTIL.getSearchParmList("content.cbMeta2", content_cbMeta2, SearchParmList)

        UTIL.getSearchParmList("ckWeights", ckWeights, SearchParmList)
        UTIL.getSearchParmList("ckMasterOnly", ckMasterOnly, SearchParmList)
        UTIL.getSearchParmList("ckMyContent", ckMyContent, SearchParmList)
        UTIL.getSearchParmList("ckLimitToLib", ckLimitToLib, SearchParmList)
        UTIL.getSearchParmList("rbEmails", rbEmails, SearchParmList)
        UTIL.getSearchParmList("rbContent", rbContent, SearchParmList)
        UTIL.getSearchParmList("rbAll", rbAll, SearchParmList)
        UTIL.getSearchParmList("nbrWeightMin", nbrWeightMin, SearchParmList)
        UTIL.getSearchParmList("cbLibrary", cbLibrary, SearchParmList)
        UTIL.getSearchParmList("txtSelDir", txtSelDir, SearchParmList)
        UTIL.getSearchParmList("CurrLoginID", CurrLoginID, SearchParmList)
        UTIL.getSearchParmList("CurrUserGuidID", CurrUserGuidID, SearchParmList)
        UTIL.getSearchParmList("isSuperAdmin", bSuperAdmin, SearchParmList)
        UTIL.getSearchParmList("isAdmin", bAdmin, SearchParmList)
        UTIL.getSearchParmList("isGlobalSearcher", bGlobalSearcher, SearchParmList)
        UTIL.getSearchParmList("UID", CurrUserGuidID, SearchParmList)
        UTIL.getSearchParmList("txtThesaurus", txtThesaurus, SearchParmList)
        UTIL.getSearchParmList("cbThesaurusText", cbThesaurusText, SearchParmList)

        UTIL.getSearchParmList("LibraryName", LibraryName, SearchParmList)
        UTIL.getSearchParmList("MinWeight", MinWeight, SearchParmList)
        UTIL.getSearchParmList("bIncludeAllLibs", bIncludeAllLibs, SearchParmList)

        UTIL.getSearchParmList("txtSearch", txtSearch, SearchParmList)
        UTIL.getSearchParmList("ckLimitToExisting", ckLimitToExisting, SearchParmList)
        UTIL.getSearchParmList("getCountOnly", getCountOnly, SearchParmList)
        UTIL.getSearchParmList("UseExistingRecordsOnly", UseExistingRecordsOnly, SearchParmList)
        UTIL.getSearchParmList("ckWeights", ckWeights, SearchParmList)
        UTIL.getSearchParmList("ckMasterOnly", ckMasterOnly, SearchParmList)
        UTIL.getSearchParmList("ckMyContent", ckMyContent, SearchParmList)
        UTIL.getSearchParmList("ckBusiness", ckBusiness, SearchParmList)
        '***************************************************************************************************

        Dim WhereClause As String = ""
        Dim bCopyToClipboard As Boolean = True
        Dim UserSql As String = ""

        If txtSearch = Nothing Then
            Debug.Print("All required variables not set to call this function.")
            'return ""
        End If
        If getCountOnly = Nothing Then
            Debug.Print("All required variables not set to call this function.")
            'return ""
        End If
        If ckWeights = Nothing Then
            Debug.Print("All required variables not set to call this function.")
            'return ""
        End If

        Dim SqlToExecute As String = ""
        Dim SqlHeader As String = ""
        '**WDM Removed 7/12/2009 SqlHeader = genHeader()
        SqlHeader += vbCrLf

        If getCountOnly Then
            SqlHeader += genContentCountSql(SecureID)
        Else

            SqlHeader += getContentTblCols(SecureID, 0, ckWeights, CurrUserGuidID, bAdmin, bGlobalSearcher)
            If ckWeights Then
                SqlHeader += genIsAbout(SecureID, ckWeights, ckBusiness, txtSearch, False)
            End If

            SqlHeader += " WHERE " + vbCrLf

            'genDocWhereClause(WhereClause)
            Dim SqlContainsClause As String = ""
            '************************************************************************************************************************************************************
            SqlContainsClause = genContainsClause(SearchParmList, SecureID, "DOC")
            '************************************************************************************************************************************************************

            SqlContainsClause = SqlContainsClause + genUseExistingRecordsOnly(SecureID, UseExistingRecordsOnly, "SourceGuid")

            '** Commented the below out on 10.14.2015 as it seems the AND is not needed (wdm)
            If SqlContainsClause.Length > 0 Then
                'SqlContainsClause = " AND " + SqlContainsClause                
                SqlContainsClause = SqlContainsClause   'Place holder
            End If

            '***********************************************************************
            If bAdmin = False Then
                bAdmin = bGlobalSearcher
            End If
            UserSql = genOwnerFilterSql(SearchParmList, SecureID)
            '***********************************************************************

            Dim SqlPart2 As String = genWhereClause2(SecureID, SearchParmList)
            Dim SqlPart3 As String = genWhereClause3(SearchParmList)

            SqlToExecute = SqlContainsClause + vbCrLf + SqlPart2 + vbCrLf + SqlPart3

            If SqlToExecute.Length > 3 Then
                Dim II As Integer = InStr(SqlToExecute, " ")
                Dim tStr As String = ""
                tStr = SqlToExecute.Substring(0, II - 1)
                tStr = tStr.Trim
                If tStr.ToUpper.Equals("AND") Or tStr.ToUpper.Equals("OR") Then
                    SqlToExecute = SqlToExecute.Substring(II - 1)
                End If
            End If

            SqlToExecute = SqlHeader + vbCrLf + SqlToExecute
            If UserSql$.Length > 0 Then
                SqlToExecute += vbCrLf + UserSql
            End If
        End If

        If getCountOnly Then
        Else
            If ckWeights = True Then
                SqlToExecute = SqlToExecute + " and KEY_TBL.RANK >= " + nbrWeightMin.ToString + vbCrLf
            Else
            End If

            If ckWeights Then
                SqlToExecute += vbCrLf + " ORDER BY KEY_TBL.RANK DESC "
            Else
                SqlToExecute += vbCrLf + " order by [SourceName] "
            End If
        End If

        ValidateNotClauses(SecureID, SqlToExecute)

        DMA.ckFreetextRemoveOr(SqlToExecute, " FREETEXT (")
        Return SqlToExecute

    End Function

    Function genContentCountSql(ByVal SecureID As Integer) As String
        Dim DocsSql$ = "Select count(*) " + vbCrLf
        DocsSql += "FROM DataSource " + vbCrLf
        Return DocsSql
    End Function

    Function genEmailCountSql(ByVal SecureID As Integer) As String
        Dim DocsSql As String = "Select count(*) " + vbCrLf
        DocsSql += "FROM EMAIL " + vbCrLf
        Return DocsSql
    End Function

    Public Function genUseExistingRecordsOnly(ByRef SecureID As Integer, ByVal bUseExisting As Boolean, ByVal GuidColName As String) As String
        If bUseExisting = False Then
            Return ""
        End If
        Dim DocsSql$ = " and " + GuidColName$ + " in (SELECT [DocGuid] FROM ActiveSearchGuids where UserID = '" + gCurrUserGuidID + "')" + vbCrLf
        Return DocsSql
    End Function

    Function genWhereClause2(ByVal SecureID As Integer, ByVal SearchParmList As SortedList(Of String, String)) As String

        '***************************************************************************************************
        '***** Load the passed in parameters
        '***************************************************************************************************
        Dim UID As String = ""
        Dim txtThesaurus As String = ""
        Dim cbThesaurusText As String = ""
        Dim LibraryName As String = ""
        Dim txtSearch As String = ""
        Dim ckLimitToLib As Boolean = False
        Dim ckLimitToExisting As Boolean = False
        Dim ckWeights As Boolean = False

        Dim bAdmin As Boolean = False
        Dim bSuperAdmin As Boolean = False
        Dim bGlobalSearcher As Boolean = False
        Dim CurrUserGuidID As String = ""
        Dim CurrLoginID As String = ""
        Dim txtSelDir As String = ""
        Dim cbLibrary As String = ""
        Dim nbrWeightMin As Integer = -1
        Dim rbAll As Boolean = False
        Dim rbContent As Boolean = False
        Dim rbEmails As Boolean = False
        Dim ckMyContent As Boolean = False
        Dim ckMasterOnly As Boolean = False
        Dim MinWeight As Integer = 0
        Dim bIncludeAllLibs As Boolean = True
        Dim ckBusiness As Boolean = False

        Dim content_ckDays As Boolean = False
        Dim content_nbrDays As Integer = Nothing
        Dim content_cbEvalCreateTime As String = ""
        Dim content_cbEvalWriteTime As String = ""
        Dim content_dtCreateDateStart As Date = Nothing
        Dim content_dtCreateDateEnd As Date = Nothing
        Dim content_dtLastWriteStart As Date = Nothing
        Dim content_dtLastWriteEnd As Date = Nothing
        Dim content_txtcbFileTypes As String = ""
        Dim content_txtFileName As String = ""
        Dim content_txtDirectory As String = ""
        Dim content_txtMetaSearch1 As String = ""
        Dim content_txtMetaSearch2 As String = ""
        Dim content_txtdtCreateDateStart As Date = Nothing
        Dim content_txtdtCreateDateEnd As Date = Nothing
        Dim content_txtdtLastWriteStart As Date = Nothing
        Dim content_cbMeta1 As String = ""
        Dim content_cbMeta2 As String = ""

        UTIL.getSearchParmList("content.ckDays", content_ckDays, SearchParmList)
        UTIL.getSearchParmList("content.nbrDays", content_nbrDays, SearchParmList)
        UTIL.getSearchParmList("content.cbEvalCreateTime", content_cbEvalCreateTime, SearchParmList)
        UTIL.getSearchParmList("content.cbEvalWriteTime", content_cbEvalWriteTime, SearchParmList)
        UTIL.getSearchParmList("content.dtCreateDateStart", content_dtCreateDateStart, SearchParmList)
        UTIL.getSearchParmList("content.dtCreateDateEnd", content_dtCreateDateEnd, SearchParmList)
        UTIL.getSearchParmList("content.dtLastWriteStart", content_dtLastWriteStart, SearchParmList)
        UTIL.getSearchParmList("content.dtLastWriteEnd", content_dtLastWriteEnd, SearchParmList)
        UTIL.getSearchParmList("content.txtFileTypes", content_txtcbFileTypes, SearchParmList)
        UTIL.getSearchParmList("content.txtFileName", content_txtFileName, SearchParmList)
        UTIL.getSearchParmList("content.txtDirectory", content_txtDirectory, SearchParmList)
        UTIL.getSearchParmList("content.txtMetaSearch1", content_txtMetaSearch1, SearchParmList)
        UTIL.getSearchParmList("content.txtMetaSearch2", content_txtMetaSearch2, SearchParmList)
        UTIL.getSearchParmList("content.txtdtCreateDateStart", content_txtdtCreateDateStart, SearchParmList)
        UTIL.getSearchParmList("content.txtdtCreateDateEnd", content_txtdtCreateDateEnd, SearchParmList)
        UTIL.getSearchParmList("content.txtdtLastWriteStart", content_txtdtLastWriteStart, SearchParmList)
        UTIL.getSearchParmList("content.cbMeta1", content_cbMeta1, SearchParmList)
        UTIL.getSearchParmList("content.cbMeta2", content_cbMeta2, SearchParmList)

        UTIL.getSearchParmList("ckWeights", ckWeights, SearchParmList)
        UTIL.getSearchParmList("ckMasterOnly", ckMasterOnly, SearchParmList)
        UTIL.getSearchParmList("ckMyContent", ckMyContent, SearchParmList)
        UTIL.getSearchParmList("ckLimitToLib", ckLimitToLib, SearchParmList)
        UTIL.getSearchParmList("rbEmails", rbEmails, SearchParmList)
        UTIL.getSearchParmList("rbContent", rbContent, SearchParmList)
        UTIL.getSearchParmList("rbAll", rbAll, SearchParmList)
        UTIL.getSearchParmList("nbrWeightMin", nbrWeightMin, SearchParmList)
        UTIL.getSearchParmList("cbLibrary", cbLibrary, SearchParmList)
        UTIL.getSearchParmList("txtSelDir", txtSelDir, SearchParmList)
        UTIL.getSearchParmList("CurrLoginID", CurrLoginID, SearchParmList)
        UTIL.getSearchParmList("CurrUserGuidID", CurrUserGuidID, SearchParmList)
        UTIL.getSearchParmList("isSuperAdmin", bSuperAdmin, SearchParmList)
        UTIL.getSearchParmList("isAdmin", bAdmin, SearchParmList)
        UTIL.getSearchParmList("isGlobalSearcher", bGlobalSearcher, SearchParmList)
        UTIL.getSearchParmList("UID", CurrUserGuidID, SearchParmList)
        UTIL.getSearchParmList("txtThesaurus", txtThesaurus, SearchParmList)
        UTIL.getSearchParmList("cbThesaurusText", cbThesaurusText, SearchParmList)

        UTIL.getSearchParmList("LibraryName", LibraryName, SearchParmList)
        UTIL.getSearchParmList("MinWeight", MinWeight, SearchParmList)
        UTIL.getSearchParmList("bIncludeAllLibs", bIncludeAllLibs, SearchParmList)

        UTIL.getSearchParmList("txtSearch", txtSearch, SearchParmList)
        UTIL.getSearchParmList("ckLimitToExisting", ckLimitToExisting, SearchParmList)
        UTIL.getSearchParmList("getCountOnly", getCountOnly, SearchParmList)
        UTIL.getSearchParmList("UseExistingRecordsOnly", UseExistingRecordsOnly, SearchParmList)
        UTIL.getSearchParmList("ckWeights", ckWeights, SearchParmList)
        UTIL.getSearchParmList("ckMasterOnly", ckMasterOnly, SearchParmList)
        UTIL.getSearchParmList("ckMyContent", ckMyContent, SearchParmList)
        UTIL.getSearchParmList("ckBusiness", ckBusiness, SearchParmList)
        '***************************************************************************************************

        Dim FirstTime As Boolean = False
        Dim S As String = ""
        Dim CH As String = ""
        Dim WhereClause As String = ""

        Dim SourceName As String = content_txtFileName
        Dim OriginalFileType As String = content_txtcbFileTypes

        Dim cbMeta1 As String = content_cbMeta1
        Dim txtMetaSearch1 As String = content_txtMetaSearch1
        Dim cbMeta2 As String = content_cbMeta2
        Dim txtMetaSearch2 As String = content_txtMetaSearch2

        S = ""

        If content_txtDirectory.Trim.Length > 0 Then
            S = S + "and  FileDirectory like '" + UTIL.RemoveSingleQuotes(content_txtDirectory.Trim) + "'" + vbCrLf
        End If
        If content_txtcbFileTypes.Trim.Length > 0 Then
            S = S + "and  OriginalFileType like '" + UTIL.RemoveSingleQuotes(content_txtcbFileTypes.Trim) + "'" + vbCrLf
        End If
        If content_txtFileName.Trim.Length > 0 Then
            S = S + "and  SourceName like '" + UTIL.RemoveSingleQuotes(content_txtFileName.Trim) + "'" + vbCrLf
        End If
        WhereClause = WhereClause + S

        '*************************************** Check the Metadata ******************************'
        Dim MetaDataWhereClause As String = ""
        MetaDataWhereClause$ = ckMetaData(SearchParmList, SecureID, cbMeta1.Trim, txtMetaSearch1.Trim, FirstTime)
        If MetaDataWhereClause$.Trim.Length > 0 Then
            If MetaDataWhereClause$.Length > 3 Then
                Dim tStr As String = Mid(MetaDataWhereClause$, 1, 3).Trim
                tStr$ = tStr$.ToUpper
                If tStr$.Equals("AND") Then
                    MetaDataWhereClause$ = " " + MetaDataWhereClause$ + " /* z22a */" + vbCrLf
                Else
                    MetaDataWhereClause$ = " AND " + MetaDataWhereClause$ + " /* z22b */" + vbCrLf
                End If
            Else
                MetaDataWhereClause$ = " AND " + MetaDataWhereClause$ + " /* z22c */" + vbCrLf
            End If
            WhereClause = WhereClause + MetaDataWhereClause$
        End If
        MetaDataWhereClause$ = ckMetaData(SearchParmList, SecureID, cbMeta2.Trim, txtMetaSearch2.Trim, FirstTime)
        If MetaDataWhereClause$.Trim.Length > 0 Then
            If MetaDataWhereClause$.Length > 3 Then
                Dim tStr As String = Mid(MetaDataWhereClause$, 1, 3).Trim
                tStr$ = tStr$.ToUpper
                If tStr$.Equals("AND") Then
                    MetaDataWhereClause$ = " " + MetaDataWhereClause$ + " /* z23a */" + vbCrLf
                Else
                    MetaDataWhereClause$ = " AND " + MetaDataWhereClause$ + " /* z23b */" + vbCrLf
                End If
            Else
                MetaDataWhereClause$ = " AND " + MetaDataWhereClause$ + " /* z23c */" + vbCrLf
            End If
            WhereClause = WhereClause + MetaDataWhereClause$
        End If

        '*************************************** END Check the Metadata ******************************'

        Return WhereClause

    End Function

    Function genWhereClause3(ByVal SearchParmList As SortedList(Of String, String)) As String

        '***************************************************************************************************
        '***** Load the passed in parameters
        '***************************************************************************************************
        Dim bAdmin As Boolean = False
        Dim bSuperAdmin As Boolean = False
        Dim bGlobalSearcher As Boolean = False
        Dim CurrUserGuidID As String = ""
        Dim CurrLoginID As String = ""
        Dim txtSelDir As String = ""
        Dim cbLibrary As String = ""
        Dim nbrWeightMin As Integer = -1
        Dim rbAll As Boolean = False
        Dim rbContent As Boolean = False
        Dim rbEmails As Boolean = False
        Dim ckMyContent As Boolean = False
        Dim ckMasterOnly As Boolean = False
        Dim ckWeights As Boolean = False
        Dim MinWeight As Integer = 0
        Dim bIncludeAllLibs As Boolean = True
        Dim ckBusiness As Boolean = False

        Dim cbThesaurusText As String = ""
        Dim ckLimitToLib As Boolean = False
        Dim UID As String = ""
        Dim txtThesaurus As String = ""
        Dim LibraryName As String = ""
        Dim txtSearch As String = ""
        Dim ckLimitToExisting As Boolean = Nothing

        Dim content_ckDays As Boolean = False
        Dim content_nbrDays As Integer = Nothing
        Dim content_cbEvalCreateTime As String = ""
        Dim content_cbEvalWriteTime As String = ""
        Dim content_dtCreateDateStart As Date = Nothing
        Dim content_dtCreateDateEnd As Date = Nothing
        Dim content_dtLastWriteStart As Date = Nothing
        Dim content_dtLastWriteEnd As Date = Nothing
        Dim content_txtcbFileTypes As String = ""
        Dim content_txtFileName As String = ""
        Dim content_txtDirectory As String = ""
        Dim content_txtMetaSearch1 As String = ""
        Dim content_txtMetaSearch2 As String = ""
        Dim content_txtdtCreateDateStart As Date = Nothing
        Dim content_txtdtCreateDateEnd As Date = Nothing
        Dim content_txtdtLastWriteStart As Date = Nothing
        Dim content_cbMeta1 As String = ""
        Dim content_cbMeta2 As String = ""

        UTIL.getSearchParmList("content.ckDays", content_ckDays, SearchParmList)
        UTIL.getSearchParmList("content.nbrDays", content_nbrDays, SearchParmList)
        UTIL.getSearchParmList("content.cbEvalCreateTime", content_cbEvalCreateTime, SearchParmList)
        UTIL.getSearchParmList("content.cbEvalWriteTime", content_cbEvalWriteTime, SearchParmList)
        UTIL.getSearchParmList("content.dtCreateDateStart", content_dtCreateDateStart, SearchParmList)
        UTIL.getSearchParmList("content.dtCreateDateEnd", content_dtCreateDateEnd, SearchParmList)
        UTIL.getSearchParmList("content.dtLastWriteStart", content_dtLastWriteStart, SearchParmList)
        UTIL.getSearchParmList("content.dtLastWriteEnd", content_dtLastWriteEnd, SearchParmList)
        UTIL.getSearchParmList("content.txtFileTypes", content_txtcbFileTypes, SearchParmList)
        UTIL.getSearchParmList("content.txtFileName", content_txtFileName, SearchParmList)
        UTIL.getSearchParmList("content.txtDirectory", content_txtDirectory, SearchParmList)
        UTIL.getSearchParmList("content.txtMetaSearch1", content_txtMetaSearch1, SearchParmList)
        UTIL.getSearchParmList("content.txtMetaSearch2", content_txtMetaSearch2, SearchParmList)
        UTIL.getSearchParmList("content.txtdtCreateDateStart", content_txtdtCreateDateStart, SearchParmList)
        UTIL.getSearchParmList("content.txtdtCreateDateEnd", content_txtdtCreateDateEnd, SearchParmList)
        UTIL.getSearchParmList("content.txtdtLastWriteStart", content_txtdtLastWriteStart, SearchParmList)
        UTIL.getSearchParmList("content.cbMeta1", content_cbMeta1, SearchParmList)
        UTIL.getSearchParmList("content.cbMeta2", content_cbMeta2, SearchParmList)

        UTIL.getSearchParmList("ckWeights", ckWeights, SearchParmList)
        UTIL.getSearchParmList("ckMasterOnly", ckMasterOnly, SearchParmList)
        UTIL.getSearchParmList("ckMyContent", ckMyContent, SearchParmList)
        UTIL.getSearchParmList("ckLimitToLib", ckLimitToLib, SearchParmList)
        UTIL.getSearchParmList("rbEmails", rbEmails, SearchParmList)
        UTIL.getSearchParmList("rbContent", rbContent, SearchParmList)
        UTIL.getSearchParmList("rbAll", rbAll, SearchParmList)
        UTIL.getSearchParmList("nbrWeightMin", nbrWeightMin, SearchParmList)
        UTIL.getSearchParmList("cbLibrary", cbLibrary, SearchParmList)
        UTIL.getSearchParmList("txtSelDir", txtSelDir, SearchParmList)
        UTIL.getSearchParmList("CurrLoginID", CurrLoginID, SearchParmList)
        UTIL.getSearchParmList("CurrUserGuidID", CurrUserGuidID, SearchParmList)
        UTIL.getSearchParmList("isSuperAdmin", bSuperAdmin, SearchParmList)
        UTIL.getSearchParmList("isAdmin", bAdmin, SearchParmList)
        UTIL.getSearchParmList("isGlobalSearcher", bGlobalSearcher, SearchParmList)
        UTIL.getSearchParmList("UID", CurrUserGuidID, SearchParmList)
        UTIL.getSearchParmList("txtThesaurus", txtThesaurus, SearchParmList)
        UTIL.getSearchParmList("cbThesaurusText", cbThesaurusText, SearchParmList)

        UTIL.getSearchParmList("LibraryName", LibraryName, SearchParmList)
        UTIL.getSearchParmList("MinWeight", MinWeight, SearchParmList)
        UTIL.getSearchParmList("bIncludeAllLibs", bIncludeAllLibs, SearchParmList)

        UTIL.getSearchParmList("txtSearch", txtSearch, SearchParmList)
        UTIL.getSearchParmList("ckLimitToExisting", ckLimitToExisting, SearchParmList)
        UTIL.getSearchParmList("getCountOnly", getCountOnly, SearchParmList)
        UTIL.getSearchParmList("UseExistingRecordsOnly", UseExistingRecordsOnly, SearchParmList)
        UTIL.getSearchParmList("ckWeights", ckWeights, SearchParmList)
        UTIL.getSearchParmList("ckMasterOnly", ckMasterOnly, SearchParmList)
        UTIL.getSearchParmList("ckMyContent", ckMyContent, SearchParmList)
        UTIL.getSearchParmList("ckBusiness", ckBusiness, SearchParmList)
        '***************************************************************************************************

        Dim FirstTime As Boolean = False
        Dim S As String = ""
        Dim CH As String = ""
        Dim WhereClause As String = ""

        Dim DbColName As String = "CreateDate"
        If Not content_cbEvalCreateTime.ToUpper.Equals("OFF") Then
            WhereClause += DMA.ckQryDate(content_dtCreateDateStart, content_dtCreateDateEnd, content_cbEvalCreateTime, DbColName, FirstTime)
        End If

        DbColName = "LastWriteTime"
        If Not content_cbEvalWriteTime.ToUpper.Equals("OFF") Then
            WhereClause += DMA.ckQryDate(content_dtLastWriteStart, content_dtLastWriteEnd, content_cbEvalWriteTime, DbColName, FirstTime)
        End If

        Return WhereClause

    End Function

    Function ckMetaData(ByVal ListOfParms As SortedList(Of String, String), ByVal SecureID As Integer, ByVal MetaDataName As String, ByVal MetaDataValue As String, ByVal FirstTime As Boolean) As String

        Dim bAdmin As String = ListOfParms.Item("isAdmin")
        Dim bGlobalSearcher As String = ListOfParms.Item("isGlobalSearcher")

        Dim S = ""
        Dim CH = ""
        Dim WhereClauseMeteData As String = ""
        If MetaDataValue.Length > 0 Then

            MetaDataValue = UTIL.RemoveSingleQuotes(MetaDataValue)

            Dim MetaDataType = getAttributeDataType(SecureID, MetaDataName)
            Dim QuotesNeeded As Boolean = QuotesRequired(MetaDataType)

            WhereClauseMeteData = " SourceGuid in (" + vbCrLf
            WhereClauseMeteData += Chr(9) + " Select D.SourceGuid" + vbCrLf
            WhereClauseMeteData += Chr(9) + " FROM DataSource AS D INNER JOIN" + vbCrLf
            WhereClauseMeteData += Chr(9) + "      SourceAttribute AS S ON D.SourceGuid = S.SourceGuid" + vbCrLf
            WhereClauseMeteData += Chr(9) + " WHERE (S.AttributeName = '" + MetaDataName + "'" + vbCrLf

            If MetaDataValue.Length > 1 Then
                If QuotesNeeded Then
                    DMA.ReplaceStar(MetaDataValue)
                End If
                If Not QuotesNeeded Then
                    MetaDataValue = MetaDataValue.Trim
                    If MetaDataValue.Length > 1 Then
                        Dim OP = Mid(MetaDataValue, 1, 1)
                        Select Case OP
                            Case "!"
                            Case ">"
                            Case "<"
                            Case "="
                            Case Else
                                MetaDataValue = " = " + MetaDataValue
                        End Select
                    End If
                End If
                If FirstTime Then
                    If QuotesNeeded Then
                        WhereClauseMeteData += Chr(9) + "   and S.AttributeValue LIKE '" + MetaDataValue + "'" + vbCrLf
                    Else
                        WhereClauseMeteData += Chr(9) + "   and S.AttributeValue" + MetaDataValue + vbCrLf
                    End If
                Else
                    If QuotesNeeded Then
                        WhereClauseMeteData += Chr(9) + "   and S.AttributeValue LIKE '" + MetaDataValue + "'" + vbCrLf
                    Else
                        WhereClauseMeteData += Chr(9) + "   and S.AttributeValue" + MetaDataValue + vbCrLf
                    End If
                End If
            End If

            If bAdmin.Equals("True") Or bGlobalSearcher.Equals("True") Then
                WhereClauseMeteData += Chr(9) + ")) " + vbCrLf
            Else
                WhereClauseMeteData += Chr(9) + " and S.DataSourceOwnerUserID = '" + gCurrUserGuidID + "')) " + vbCrLf
            End If

        End If
        Return WhereClauseMeteData
    End Function

    Function getAttributeDataType(ByRef SecureID As Integer, ByVal AttributeName As String) As String

        Dim DB As New clsDatabaseSVR

        Dim tVal As String = ""
        Dim S As String = "Select AttributeDataType FROM [Attributes] where AttributeName = '" + AttributeName + "'"

        Try
            Dim RSData As SqlDataReader = Nothing
            Dim CS As String = DBgetConnStr()
            Dim CONN As New SqlConnection(CS)

            CONN.Open()
            Dim command As New SqlCommand(S, CONN)
            RSData = command.ExecuteReader()

            If RSData.HasRows Then
                RSData.Read()
                tVal$ = RSData.GetValue(0).ToString
                'Application.DoEvents()
            Else
                tVal = ""
            End If

            RSData.Close()
            RSData = Nothing

            Return tVal$
        Catch ex As Exception
            DB.DBTrace(SecureID, 23.34, "getAttributeDataType", "clsDatabase", ex)
            DB.DBLogMessage(SecureID, gCurrUserGuidID, "clsDatabase : getAttributeDataType : 5957 : " + ex.Message)
            Return ""
        End Try

        DB = Nothing
        GC.Collect()
        GC.WaitForPendingFinalizers()

    End Function

    Function getEmailTblCols(ByRef SecureID As Integer, ByVal iMaxRows As Integer, ByVal ckWeights As Boolean, ByVal ckBusiness As Boolean, ByVal SearchText As String, UserID As String, isAdmin As Boolean, isGlobalSearcher As Boolean) As String
        Dim SearchSql = ""

        If ckWeights = True Then
            If iMaxRows > 0 Then
                If iMaxRows > 0 Then
                    SearchSql = " SELECT TOP " + iMaxRows.ToString
                Else
                    SearchSql = " SELECT "
                End If
            Else
                SearchSql = " SELECT "
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
            SearchSql = SearchSql + " ,DS.EmailGuid, DS.RetentionExpirationDate, DS.isPublic, DS.UserID, DS.OriginalFileType, DS.NbrAttachments , ' ' as RID, RepoSvrName  " + vbCrLf
            SearchSql = SearchSql + " FROM EMAIL AS DS " + vbCrLf

            If (Not isAdmin And Not isGlobalSearcher) Then
                Dim JoinStr As String = genInnerJoin("E", UserID)
                JoinStr = "/* " + JoinStr + " 0015 */"
                SearchSql += JoinStr
            End If

            SearchSql += genIsAbout(SecureID, ckWeights, ckBusiness, SearchText, True)
        Else
            If iMaxRows > 0 Then
                If iMaxRows > 0 Then
                    SearchSql = " SELECT TOP " + iMaxRows.ToString
                Else
                    SearchSql = " SELECT "
                End If
            Else
                SearchSql = " SELECT "
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
            SearchSql = SearchSql + " ,[EmailGuid], RetentionExpirationDate, isPublic, EMAIL.UserID, OriginalFileType, NbrAttachments, ' ' as RID, RepoSvrName, 0 as RANK " + vbCrLf

            If (Not isAdmin And Not isGlobalSearcher) Then
                Dim JoinStr As String = genInnerJoin("E", UserID)
                JoinStr += " /* 0015 */"
                SearchSql += JoinStr
            Else
                SearchSql = SearchSql + " FROM EMAIL " + vbCrLf
            End If

        End If
        Return SearchSql
    End Function

    Function genSearchSQL(ByVal TypeSearch As String, ByVal SearchParmList As Dictionary(Of String, String)) As String

        Dim sList As New SortedList(Of String, String)

        For Each skey In SearchParmList.Keys
            sList.Add(skey, SearchParmList(skey))
        Next

        Dim MySql As String = ""

        If (TypeSearch.Equals("EMAIL")) Then
            MySql = GenEmailGeneratedSQL(sList, 0, 999999)
        ElseIf (TypeSearch.Equals("CONTENT")) Then
            MySql = GenContentSearchSQL(sList, 0)
        Else
            MySql = GenEmailGeneratedSQL(sList, 0, 999999)
            MySql += vbCrLf + "--*****************************************************--"
            MySql += GenContentSearchSQL(sList, 0)
        End If

        Return MySql

    End Function

    ''' <summary>
    ''' Generates the SQL for searching emails. 
    ''' Generate SQL
    ''' </summary>
    ''' <param name="SearchParmList">The search parm list.</param>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="iMaxRecs">The i maximum recs.</param>
    ''' <returns></returns>
    Function GenEmailGeneratedSQL(ByVal SearchParmList As SortedList(Of String, String), ByRef SecureID As Integer, ByVal iMaxRecs As Integer) As String

        '***************************************************************************************************
        '***** Load the passed in parameters
        '***************************************************************************************************
        Dim SqlHeader As String = ""
        Dim bAdmin As Boolean = False
        Dim bSuperAdmin As Boolean = False
        Dim bGlobalSearcher As Boolean = False
        Dim CurrUserGuidID As String = ""
        Dim CurrLoginID As String = ""
        Dim txtSelDir As String = ""
        Dim cbLibrary As String = ""
        Dim nbrWeightMin As Integer = -1
        Dim rbAll As Boolean = False
        Dim rbContent As Boolean = False
        Dim rbEmails As Boolean = False
        Dim ckMyContent As Boolean = False
        Dim ckMasterOnly As Boolean = False
        Dim ckWeights As Boolean = False

        Dim cbDateSelection As String = ""
        Dim calStart As Date = Nothing
        Dim calEnd As Date = Nothing
        Dim dtMailDateStart As Date = Nothing
        Dim dtMailDateEnd As Date = Nothing
        Dim cbFromAddr As String = ""
        Dim txtSubject As String = ""
        Dim txtCCPhrase As String = ""
        Dim cbFromName As String = ""
        Dim cbToName As String = ""
        Dim cbFolderFilter As String = ""
        Dim cbCCaddr As String = ""
        Dim ckLimitToLib As Boolean = Nothing
        Dim txtThesaurus As String = ""
        Dim UID As String = Nothing
        Dim cbThesaurusText As String = Nothing
        Dim LibraryName As String = Nothing
        Dim MinWeight As Integer = Nothing
        Dim bIncludeAllLibs As Boolean = Nothing
        Dim txtSearch As String = Nothing
        Dim ckLimitToExisting As Boolean = Nothing
        Dim ckBusiness As Boolean = False

        UTIL.getSearchParmList("email.cbCCaddr", cbCCaddr, SearchParmList)
        UTIL.getSearchParmList("email.cbFolderFilter", cbFolderFilter, SearchParmList)
        UTIL.getSearchParmList("email.cbToName", cbToName, SearchParmList)

        UTIL.getSearchParmList("email.cbFromName", cbFromName, SearchParmList)
        UTIL.getSearchParmList("email.txtCCPhrase", txtCCPhrase, SearchParmList)
        UTIL.getSearchParmList("email.txtSubject", txtSubject, SearchParmList)
        UTIL.getSearchParmList("email.cbFromAddr", cbFromAddr, SearchParmList)

        UTIL.getSearchParmList("email.dtMailDateEnd", dtMailDateEnd, SearchParmList)
        UTIL.getSearchParmList("email.dtMailDateStart", dtMailDateStart, SearchParmList)

        UTIL.getSearchParmList("email.dtMailDateEnd", dtMailDateEnd, SearchParmList)
        UTIL.getSearchParmList("email.dtMailDateStart", dtMailDateStart, SearchParmList)

        UTIL.getSearchParmList("email.cbDateSelection", cbDateSelection, SearchParmList)
        UTIL.getSearchParmList("email.calStart", calStart, SearchParmList)
        UTIL.getSearchParmList("email.calEnd", calEnd, SearchParmList)

        UTIL.getSearchParmList("ckWeights", ckWeights, SearchParmList)
        UTIL.getSearchParmList("ckMasterOnly", ckMasterOnly, SearchParmList)
        UTIL.getSearchParmList("ckMyContent", ckMyContent, SearchParmList)
        UTIL.getSearchParmList("ckLimitToLib", ckLimitToLib, SearchParmList)
        UTIL.getSearchParmList("rbEmails", rbEmails, SearchParmList)
        UTIL.getSearchParmList("rbContent", rbContent, SearchParmList)
        UTIL.getSearchParmList("rbAll", rbAll, SearchParmList)
        UTIL.getSearchParmList("nbrWeightMin", nbrWeightMin, SearchParmList)
        UTIL.getSearchParmList("cbLibrary", cbLibrary, SearchParmList)
        UTIL.getSearchParmList("txtSelDir", txtSelDir, SearchParmList)
        UTIL.getSearchParmList("CurrLoginID", CurrLoginID, SearchParmList)
        UTIL.getSearchParmList("CurrUserGuidID", CurrUserGuidID, SearchParmList)
        UTIL.getSearchParmList("isSuperAdmin", bSuperAdmin, SearchParmList)
        UTIL.getSearchParmList("isAdmin", bAdmin, SearchParmList)
        UTIL.getSearchParmList("isGlobalSearcher", bGlobalSearcher, SearchParmList)
        UTIL.getSearchParmList("UID", UID, SearchParmList)
        UTIL.getSearchParmList("txtThesaurus", txtThesaurus, SearchParmList)
        UTIL.getSearchParmList("cbThesaurusText", cbThesaurusText, SearchParmList)

        UTIL.getSearchParmList("LibraryName", LibraryName, SearchParmList)
        UTIL.getSearchParmList("MinWeight", MinWeight, SearchParmList)
        UTIL.getSearchParmList("bIncludeAllLibs", bIncludeAllLibs, SearchParmList)

        UTIL.getSearchParmList("txtSearch", txtSearch, SearchParmList)
        UTIL.getSearchParmList("ckLimitToExisting", ckLimitToExisting, SearchParmList)
        UTIL.getSearchParmList("txtSearch", txtSearch, SearchParmList)
        UTIL.getSearchParmList("getCountOnly", getCountOnly, SearchParmList)
        UTIL.getSearchParmList("UseExistingRecordsOnly", UseExistingRecordsOnly, SearchParmList)
        UTIL.getSearchParmList("ckWeights", ckWeights, SearchParmList)
        UTIL.getSearchParmList("ckMasterOnly", ckMasterOnly, SearchParmList)
        UTIL.getSearchParmList("ckMyContent", ckMyContent, SearchParmList)
        UTIL.getSearchParmList("ckBusiness", ckBusiness, SearchParmList)
        '***************************************************************************************************

        If txtSearch = Nothing Then
            Debug.Print("All required variables Not Set To Call this Function.")
            'return ""
        Else

        End If
        If getCountOnly = Nothing Then
            Debug.Print("All required variables Not Set To Call this Function.")
            'return ""
        End If
        If UseExistingRecordsOnly = Nothing Then
            Debug.Print("All required variables Not Set To Call this Function.")
            'return ""
        Else
            UseExistingRecordsOnly = ckLimitToExisting
        End If
        If ckWeights = Nothing Then
            Debug.Print("All required variables Not Set To Call this Function.")
            'return ""
        End If
        If SqlHeader = Nothing Then
            Debug.Print("All required variables Not Set To Call this Function.")
            'return ""
        End If

        If bAdmin = False Then
            bAdmin = bGlobalSearcher
        End If
        If bAdmin = Nothing Then
            Debug.Print("All required variables Not Set To Call this Function.")
            'return ""
        End If
        If ckBusiness = Nothing Then
            Debug.Print("All required variables Not Set To Call this Function.")
            'return ""
        End If

        Dim SqlBody = ""
        Dim bCopyToClipboard As Boolean = True

        Dim UserSql As String = genAdminEmailSql(SecureID, SearchParmList)

        If getCountOnly Then
            SqlHeader += genEmailCountSql(SecureID)
        Else
            SqlHeader += getEmailTblCols(SecureID, 0, ckWeights, ckBusiness, txtSearch, CurrUserGuidID, bAdmin, bGlobalSearcher)
        End If

        SqlHeader = SqlHeader + " WHERE " + vbCrLf

        Dim SqlContains As String = ""
        SqlContains = genContainsClause(SearchParmList, SecureID, "EMAIL")

        If SqlContains.Length > 0 Then
            SqlContains = "And " + SqlContains
        End If

        Dim SqlParameters As String = genWhereClausePartII(SearchParmList)
        If SqlContains.Length > 0 Then
            SqlContains = SqlContains + vbCrLf + SqlParameters
        End If

        If SqlContains.Length > 0 Then
            Dim FirstWord As String = ""
            Dim iBlank As Integer = InStr(SqlContains, " ")
            If iBlank > 0 Then
                FirstWord = SqlContains.Substring(0, iBlank - 1)
                If FirstWord.ToUpper.Equals("AND") Or FirstWord.ToUpper.Equals("OR") Then
                    SqlContains = SqlContains.Substring(iBlank - 1)
                    SqlContains = SqlContains.Trim
                End If
            End If
        End If

        SqlBody = SqlBody + vbCrLf + SqlContains + vbCrLf
        SqlBody = SqlBody.Trim

        Dim SqlToExecute As String = ""

        If SqlContains.Trim.Length > 0 Then

            SqlToExecute = SqlHeader + SqlBody

            If getCountOnly Then
                SqlToExecute += UserSql
            Else
                SqlToExecute += vbCrLf + UserSql

                If ckWeights = True Then
                    SqlToExecute += "    And KEY_TBL.RANK >= " + nbrWeightMin.ToString + vbCrLf

                    Dim IncludeEmailAttachmentsQry$ = SqlToExecute + vbCrLf
                    'If ckIncludeAttachments.Checked Then
                    Dim ckIncludeAttachments As Boolean = True

                    If ckWeights = True Then
                        IncludeEmailAttachmentsSearchWeighted(SearchParmList, SecureID, UID, ckIncludeAttachments, ckWeights, ckBusiness, txtSearch, ckLimitToExisting, txtThesaurus, cbThesaurusText, MinWeight)
                    Else
                        IncludeEmailAttachmentsSearch(SearchParmList, SecureID, UID, ckIncludeAttachments, ckWeights, ckBusiness, txtSearch, ckLimitToExisting, txtThesaurus, cbThesaurusText, LibraryName$, bIncludeAllLibs, bAdmin, bGlobalSearcher)
                    End If

                    If ckIncludeAttachments = True And ckLimitToLib = False Then
                        '** ECM EmailAttachmentSearchList
                        If gMasterContentOnly = True Then
                        Else
                            'IncludeEmailAttachmentsQry$ = vbCrLf + " Or " + "([EmailGuid] In (Select EmailGuid from EmailAttachmentSearchList where UserID = '" + UID + "'))" + vbCrLf
                        End If

                        'SqlBody = SqlBody + vbCrLf + IncludeEmailAttachmentsQry$ + vbCrLf
                        SqlToExecute = SqlToExecute + genUseExistingRecordsOnly(SecureID, UseExistingRecordsOnly, "EmailGuid")

                        'Clipboard.Clear()
                        'Clipboard.SetText(SqlBody)
                    End If
                    'SqlBody += vbCrLf + " or isPublic = 'Y' "
                    SqlToExecute += vbCrLf + " ORDER BY KEY_TBL.RANK DESC " + vbCrLf

                Else
                    Dim IncludeEmailAttachmentsQry$ = SqlBody + vbCrLf
                    Dim ckIncludeAttachments As Boolean = True
                    IncludeEmailAttachmentsSearch(SearchParmList, SecureID, UID, ckIncludeAttachments, ckWeights, ckBusiness, txtSearch, ckLimitToExisting, txtThesaurus, cbThesaurusText, LibraryName$, bIncludeAllLibs, bAdmin, bGlobalSearcher)
                    SqlToExecute += vbCrLf + " order by [EMAIL].[SentOn] "
                End If
            End If
        Else
            SqlToExecute = ""
        End If

        If SqlToExecute.Length > 0 Then
            ValidateNotClauses(SecureID, SqlBody)
            DMA.ckFreetextRemoveOr(SqlBody, "freetext ((Body, Description, KeyWords, Subject, Attachment, Ocrtext)")
            DMA.ckFreetextRemoveOr(SqlBody, "freetext (body")
            DMA.ckFreetextRemoveOr(SqlBody, "freetext (subject")
        End If

        Return SqlToExecute

    End Function

    Sub IncludeEmailAttachmentsSearchWeighted(ByVal SearchParmList As SortedList(Of String, String),
                                              ByRef SecureID As Integer, ByVal UID As String, ByVal ckIncludeAttachments As Boolean,
                                              ByVal ckWeights As Boolean, ByVal ckBusiness As Boolean, ByVal SearchText As String, ByVal ckLimitToExisting As Boolean,
                                              ByVal txtThesaurus As String, ByVal cbThesaurusText As String, ByVal MinWeight As Integer)

        Dim DB As New clsDatabaseSVR

        If ckIncludeAttachments Then
            Dim SS As String = "delete FROM [EmailAttachmentSearchList] where [UserID] = '" + UID + "'"

            Dim BB As Boolean = DB.DBExecuteSql(SecureID, SS)
            If Not BB Then
                DB.DBTrace(SecureID, 996732, "IncludeEmailAttachmentsSearchWeighted", SS)
                MsgBox("Failed to initialize Attachment Content Search. Content search is not included in the results.")
            Else
                Dim EmailContentWhereClause = ""
                Dim insertSql As String = ""
                EmailContentWhereClause = genContainsClause(SearchParmList, SecureID, "EMAIL")

                Dim SS1$ = EmailContentWhereClause.Replace("CONTAINS(BODY", "CONTAINS(Attachment")
                Dim SS2$ = SS1.Replace("CONTAINS(SUBJECT", "CONTAINS(OcrText")
                SS1 = SS2

                insertSql$ = SS1$
                If ckBusiness Then
                    GetSubContainsClauseWeighted(SecureID, UID, SearchText, insertSql, True, MinWeight)
                Else
                    GetSubContainsClauseWeighted(SecureID, UID, SearchText, insertSql, False, MinWeight)
                End If

                ' LOG.WriteToAttachmentSearchLog("EmailAttachmentsSearch Weighted: " + insertSql + vbCrLf + vbCrLf)

                BB = DB.DBExecuteSql(SecureID, insertSql, False)
                If Not BB Then
                    DB.DBLogMessage(SecureID, gCurrUserGuidID, "clsGenerator:IncludeEmailAttachmentsSearchWeighted : Failed to insert Attachment Content Search. Content search is not included in the results.")
                    DB.DBLogMessage(SecureID, gCurrUserGuidID, "clsGenerator:IncludeEmailAttachmentsSearchWeighted : The SQL Stmt: " + insertSql)
                    NbrOfErrors += 1
                    'FrmMDIMain.SB.Text = "Errors: " + NbrOfErrors.ToString
                End If
            End If
        End If

        DB = Nothing
        GC.Collect()
        GC.WaitForPendingFinalizers()

    End Sub

    Public Sub ValidateNotClauses(ByRef SecureID As Integer, ByRef SqlText As String)
        If SqlText.Trim.Length = 0 Then
            Return
        End If

        Dim DoThis As Boolean = False

        If Not DoThis Then
            Return
        End If

        Dim DB As New clsDatabaseSVR
        Dim I As Integer = 0
        Dim prevWord As String = ""
        Dim currWord As String = ""
        Dim CH As String = ""
        Dim aList As New ArrayList
        For I = 1 To SqlText.Length
            CH = Mid(SqlText, I, 1)
            If CH = Chr(34) Then
                I = I + 1
                CH = Mid(SqlText, I, 1)
                Do While CH <> Chr(34) And I <= SqlText.Length
                    I = I + 1
                    CH = Mid(SqlText, I, 1)
                Loop
            ElseIf CH = " " Then
                Mid(SqlText, I, 1) = Chr(254)
            End If
        Next
        Dim A$() = SqlText.Split(Chr(254))
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
                'currWord = "Not"
                aList.Add(currWord)
            ElseIf UCase(currWord).Equals("FORMSOF") And Not UCase(prevWord).Equals("AND") Then
                currWord = "FormsOF"
                aList.Add(currWord)
            Else
                aList.Add(currWord)
            End If
            prevWord = currWord
        Next
        SqlText = ""
        For I = 0 To aList.Count - 1
            Try
                'If aList(I) = Nothing Then
                '    Debug.Print("nothing")
                '    Dim X# = 1
                'Else
                Dim tWord$ = aList(I)
                Dim EOL As String = ""
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
                DB.DBLogMessage(SecureID, gCurrUserGuidID, ex.Message)
            End Try
        Next

        DB = Nothing
        GC.Collect()
        GC.WaitForPendingFinalizers()

    End Sub

    Sub GetSubContainsClauseWeighted(ByRef SecureID As Integer, ByVal UID As String, ByVal SearchText As String, ByRef ContainsClause As String, ByVal isFreetext As Boolean, ByVal MinWeight As Integer)
        Dim S As String = ""

        Dim I As Integer = 0

        Try
            Dim CorrectedSearchClause As String = CleanIsAboutSearchText(SecureID, SearchText)
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
            S = S + "        ON RowGuid = KEY_TBL.[KEY]" + vbCrLf
            S = S + "   WHERE " + vbCrLf

            If isFreetext = False Then
                ContainsClause$ = ContainsClause$ + " and ((UserID is not null) and UserID = '" + UID + "' and KEY_TBL.RANK > " + MinWeight.ToString + " or isPublic = 'Y')"

                Dim JoinStr As String = genInnerJoin("A", "XXXX")
                JoinStr = "/* " + JoinStr + " 0017 */"
                ContainsClause$ += JoinStr

                ContainsClause$ = S + ContainsClause$ + vbCrLf
                Return
            End If

            S$ = ContainsClause$
            I = 0
            I = InStr(S, "(")
            Mid(ContainsClause, I, 1) = " "
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

    Function CleanIsAboutSearchText(ByRef SecureID As Integer, ByVal SearchText As String) As String
        Dim I As Integer = 0
        Dim A As New ArrayList
        Dim CH As String = ""
        Dim Token As String = ""
        Dim S As String = ""
        Dim SkipNextToken As Boolean = False
        For I = 1 To SearchText.Trim.Length
REEVAL:
            CH = Mid(SearchText, I, 1)
            If CH.Equals(Chr(34)) Then
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
                Do While CH <> Chr(34) And I <= SearchText.Length
                    I += 1
                    CH = Mid(SearchText, I, 1)
                    Token += CH
                Loop
                'Token = Chr(34) + Token
                If PreceedingPlusSign = True Then
                    Token = "+" + Chr(34) + Token
                    'Dim NextChar$ = getNextChar(SearchText, I)
                    'If NextChar$ = "-" Then
                    '    '** We skip the next token in the stmt
                    'End If
                ElseIf PreceedingMinusSign = True Then
                    Token = "-" + Chr(34) + Token
                    'Dim NextChar$ = getNextChar(SearchText, I)
                    'If NextChar$ = "+" Then
                    '    '** We skip the next token in the stmt
                    'End If
                Else
                    Token = Chr(34) + Token
                End If
                A.Add(Token)

                Token = ""
            ElseIf CH.Equals(" ") Or CH = " " Then
                '** Skip the blank spaces
                If Token.Equals("+") Or Token.Equals("-") Then
                    Debug.Print("Should not be here.")
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
                Dim NextChar$ = getNextChar(SecureID, SearchText, I)
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
                Dim NextChar$ = getNextChar(SecureID, SearchText, I)
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
                    If dDebug Then
                        Debug.Print(S)
                    End If
                End If
            End If
        Next
        Return S
    End Function

    Function genAdminEmailSql(ByRef SecureID As Integer, ByRef SearchParmList As SortedList(Of String, String)) As String
        Dim UserSql As String = ""

        '***************************************************************************************************
        '***** Load the passed in parameters
        '***************************************************************************************************
        Dim UID As String = ""
        Dim txtThesaurus As String = ""
        Dim cbThesaurusText As String = ""
        Dim LibraryName As String = ""
        Dim txtSearch As String = ""
        Dim ckLimitToLib As Boolean = False
        Dim ckLimitToExisting As Boolean = False
        Dim ckWeights As Boolean = False

        Dim bAdmin As Boolean = False
        Dim bSuperAdmin As Boolean = False
        Dim bGlobalSearcher As Boolean = False
        Dim CurrUserGuidID As String = ""
        Dim CurrLoginID As String = ""
        Dim txtSelDir As String = ""
        Dim cbLibrary As String = ""
        Dim nbrWeightMin As Integer = -1
        Dim rbAll As Boolean = False
        Dim rbContent As Boolean = False
        Dim rbEmails As Boolean = False
        Dim ckMyContent As Boolean = False
        Dim ckMasterOnly As Boolean = False
        Dim MinWeight As Integer = 0
        Dim bIncludeAllLibs As Boolean = True
        Dim ckBusiness As Boolean = False

        Dim content_ckDays As Boolean = False
        Dim content_nbrDays As Integer = Nothing
        Dim content_cbEvalCreateTime As String = ""
        Dim content_cbEvalWriteTime As String = ""
        Dim content_dtCreateDateStart As Date = Nothing
        Dim content_dtCreateDateEnd As Date = Nothing
        Dim content_dtLastWriteStart As Date = Nothing
        Dim content_dtLastWriteEnd As Date = Nothing
        Dim content_txtcbFileTypes As String = ""
        Dim content_txtFileName As String = ""
        Dim content_txtDirectory As String = ""
        Dim content_txtMetaSearch1 As String = ""
        Dim content_txtMetaSearch2 As String = ""
        Dim content_txtdtCreateDateStart As Date = Nothing
        Dim content_txtdtCreateDateEnd As Date = Nothing
        Dim content_txtdtLastWriteStart As Date = Nothing
        Dim content_cbMeta1 As String = ""
        Dim content_cbMeta2 As String = ""

        UTIL.getSearchParmList("content.ckDays", content_ckDays, SearchParmList)
        UTIL.getSearchParmList("content.nbrDays", content_nbrDays, SearchParmList)
        UTIL.getSearchParmList("content.cbEvalCreateTime", content_cbEvalCreateTime, SearchParmList)
        UTIL.getSearchParmList("content.cbEvalWriteTime", content_cbEvalWriteTime, SearchParmList)
        UTIL.getSearchParmList("content.dtCreateDateStart", content_dtCreateDateStart, SearchParmList)
        UTIL.getSearchParmList("content.dtCreateDateEnd", content_dtCreateDateEnd, SearchParmList)
        UTIL.getSearchParmList("content.dtLastWriteStart", content_dtLastWriteStart, SearchParmList)
        UTIL.getSearchParmList("content.dtLastWriteEnd", content_dtLastWriteEnd, SearchParmList)
        UTIL.getSearchParmList("content.txtFileTypes", content_txtcbFileTypes, SearchParmList)
        UTIL.getSearchParmList("content.txtFileName", content_txtFileName, SearchParmList)
        UTIL.getSearchParmList("content.txtDirectory", content_txtDirectory, SearchParmList)
        UTIL.getSearchParmList("content.txtMetaSearch1", content_txtMetaSearch1, SearchParmList)
        UTIL.getSearchParmList("content.txtMetaSearch2", content_txtMetaSearch2, SearchParmList)
        UTIL.getSearchParmList("content.txtdtCreateDateStart", content_txtdtCreateDateStart, SearchParmList)
        UTIL.getSearchParmList("content.txtdtCreateDateEnd", content_txtdtCreateDateEnd, SearchParmList)
        UTIL.getSearchParmList("content.txtdtLastWriteStart", content_txtdtLastWriteStart, SearchParmList)
        UTIL.getSearchParmList("content.cbMeta1", content_cbMeta1, SearchParmList)
        UTIL.getSearchParmList("content.cbMeta2", content_cbMeta2, SearchParmList)

        UTIL.getSearchParmList("ckWeights", ckWeights, SearchParmList)
        UTIL.getSearchParmList("ckMasterOnly", ckMasterOnly, SearchParmList)
        UTIL.getSearchParmList("ckMyContent", ckMyContent, SearchParmList)
        UTIL.getSearchParmList("ckLimitToLib", ckLimitToLib, SearchParmList)
        UTIL.getSearchParmList("rbEmails", rbEmails, SearchParmList)
        UTIL.getSearchParmList("rbContent", rbContent, SearchParmList)
        UTIL.getSearchParmList("rbAll", rbAll, SearchParmList)
        UTIL.getSearchParmList("nbrWeightMin", nbrWeightMin, SearchParmList)
        UTIL.getSearchParmList("cbLibrary", cbLibrary, SearchParmList)
        UTIL.getSearchParmList("txtSelDir", txtSelDir, SearchParmList)
        UTIL.getSearchParmList("CurrLoginID", CurrLoginID, SearchParmList)
        UTIL.getSearchParmList("CurrUserGuidID", CurrUserGuidID, SearchParmList)
        UTIL.getSearchParmList("isSuperAdmin", bSuperAdmin, SearchParmList)
        UTIL.getSearchParmList("isAdmin", bAdmin, SearchParmList)
        UTIL.getSearchParmList("isGlobalSearcher", bGlobalSearcher, SearchParmList)
        UTIL.getSearchParmList("UID", CurrUserGuidID, SearchParmList)
        UTIL.getSearchParmList("txtThesaurus", txtThesaurus, SearchParmList)
        UTIL.getSearchParmList("cbThesaurusText", cbThesaurusText, SearchParmList)

        UTIL.getSearchParmList("LibraryName", LibraryName, SearchParmList)
        UTIL.getSearchParmList("MinWeight", MinWeight, SearchParmList)
        UTIL.getSearchParmList("bIncludeAllLibs", bIncludeAllLibs, SearchParmList)

        UTIL.getSearchParmList("txtSearch", txtSearch, SearchParmList)
        UTIL.getSearchParmList("ckLimitToExisting", ckLimitToExisting, SearchParmList)
        UTIL.getSearchParmList("getCountOnly", getCountOnly, SearchParmList)
        UTIL.getSearchParmList("UseExistingRecordsOnly", UseExistingRecordsOnly, SearchParmList)
        UTIL.getSearchParmList("ckWeights", ckWeights, SearchParmList)
        UTIL.getSearchParmList("ckMasterOnly", ckMasterOnly, SearchParmList)
        UTIL.getSearchParmList("ckMyContent", ckMyContent, SearchParmList)
        UTIL.getSearchParmList("ckBusiness", ckBusiness, SearchParmList)
        '***************************************************************************************************

        LibraryName = UTIL.RemoveSingleQuotes(LibraryName)

        If bAdmin Or bGlobalSearcher Then
            '** ECM WhereClause
            If ckLimitToLib = True Then
                '** DO NOT PUT vbcrlf at the end of the below lines. That will cause problems in inserting PAGING.
                Dim gSearcher As Boolean = False
                If bAdmin = True Or bGlobalSearcher = True Then
                    gSearcher = True
                End If
                UserSql = UserSql + " AND EmailGuid in (" + genLibrarySearch(CurrUserGuidID, gSearcher, LibraryName, "Gen@10") + ")"
            Else
                If ckMyContent = True Then

                    UserSql = UserSql + " and ( UserID = '" + CurrUserGuidID + "') " + vbCrLf

                    Dim JoinStr As String = genInnerJoin("A", CurrUserGuidID)
                    JoinStr = "/* " + JoinStr + " 0018 */"
                    UserSql += JoinStr

                Else
                    Dim gSearcher As Boolean = False
                    If bAdmin = True Or bGlobalSearcher = True Then
                        gSearcher = True
                    End If
                    Dim IncludeLibsSql As String = genLibrarySearch(CurrUserGuidID, False, gSearcher, "@Gen34")
                    UserSql = UserSql + IncludeLibsSql
                End If
                If ckMasterOnly = True Then
                    UserSql = UserSql + " and ( isMaster = 'Y' )     /*KEEP*/" + vbCrLf
                End If
            End If
        Else
            If ckLimitToLib = True Then
                Dim gSearcher As Boolean = False
                If bAdmin = True Or bGlobalSearcher = True Then
                    gSearcher = True
                End If
                UserSql = UserSql + " AND EmailGuid in (" + genLibrarySearch(CurrUserGuidID, gSearcher, LibraryName, "Gen@11") + ")"
            Else
                '** ECM WhereClause
                If ckMyContent = True Then

                    UserSql = UserSql + " and ( UserID = '" + CurrUserGuidID + "') " + vbCrLf

                    Dim JoinStr As String = genInnerJoin("A", CurrUserGuidID)
                    JoinStr = "/* " + JoinStr + " 0019 */"
                    UserSql += JoinStr

                Else
                    Dim gSearcher As Boolean = False
                    If bAdmin = True Or bGlobalSearcher = True Then
                        gSearcher = True
                    End If
                    Dim IncludeLibsSql As String = genLibrarySearch(CurrUserGuidID, False, gSearcher, "@Gen30")
                    UserSql = UserSql + IncludeLibsSql
                End If

                If ckMasterOnly = True Then
                    UserSql = UserSql + " and ( isMaster = 'Y' )      /*KEEP*/" + vbCrLf
                End If

            End If
        End If
        Return UserSql
    End Function

    Function genWhereClausePartII(ByVal ListOfParms As SortedList(Of String, String)) As String
        Dim S As String = ""

        Dim DbColName As String = ""

        Dim cbFromAddr As String = getSearchParmVal("email.cbFromAddr", ListOfParms)
        Dim cbToAddr As String = getSearchParmVal("email.cbToAddr", ListOfParms)
        Dim cbFromName As String = getSearchParmVal("email.cbFromName", ListOfParms)
        Dim cbToName As String = getSearchParmVal("email.cbToName", ListOfParms)
        Dim cbFolderFilter As String = getSearchParmVal("email.cbFolderFilter", ListOfParms)
        Dim txtSubject As String = getSearchParmVal("email.txtSubject", ListOfParms)
        Dim cbCCaddr As String = getSearchParmVal("email.cbCCaddr", ListOfParms)
        Dim txtCCPhrase As String = getSearchParmVal("email.txtCCPhrase", ListOfParms)
        Dim cbDateSelection As String = getSearchParmVal("email.cbDateSelection", ListOfParms)
        Dim ckCreationDate As String = getSearchParmVal("email.ckCreationDate", ListOfParms)
        Dim dtMailDateStart As String = getSearchParmVal("email.dtMailDateStart", ListOfParms)
        Dim dtMailDateEnd As String = getSearchParmVal("email.dtMailDateEnd", ListOfParms)

        Dim FirstTime As Boolean = True

        If cbFromAddr.Trim.Length > 0 Then
            S = S + "and  SenderEmailAddress like '" + UTIL.RemoveSingleQuotes(cbFromAddr.Trim) + "'" + vbCrLf
        End If

        If cbToAddr.Trim.Length > 0 Then
            S = S + "and ( SentTO like '" + UTIL.RemoveSingleQuotes(cbToAddr.Trim) + "' or "
            S = S + " AllRecipients like '" + UTIL.RemoveSingleQuotes(cbToAddr.Trim) + "') " + vbCrLf
        End If

        If cbFromName.Trim.Length > 0 Then
            S = S + " and SenderName like '" + UTIL.RemoveSingleQuotes(cbFromName.Trim) + "' " + vbCrLf
        End If

        If cbToName.Trim.Length > 0 Then
            S = S + " and ReceivedByName like '" + UTIL.RemoveSingleQuotes(cbToName.Trim) + "' " + vbCrLf
        End If

        If cbFolderFilter.Trim.Length > 0 Then
            S = S + " and OriginalFolder LIKE '" + UTIL.RemoveSingleQuotes(cbFolderFilter.Trim) + "'  " + vbCrLf
        End If

        If txtSubject.Trim.Length > 0 Then
            DMA.ReplaceStar(txtSubject.Trim)
            S = S + " and SUBJECT Like '" + txtSubject.Trim + "' " + vbCrLf
        End If

        If cbCCaddr.Trim.Length > 0 Then
            DMA.ReplaceStar(UTIL.RemoveSingleQuotes(cbCCaddr.Trim))
            S = S + " and (CC like '" + UTIL.RemoveSingleQuotes(cbCCaddr.Trim) + "' or "
            S = S + " BCC like '" + UTIL.RemoveSingleQuotes(cbCCaddr.Trim) + "') " + vbCrLf
        End If
        If txtCCPhrase.Trim.Length > 0 Then
            DMA.ReplaceStar(UTIL.RemoveSingleQuotes(txtCCPhrase.Trim))
            S = S + " and (AllRecipients like '" + UTIL.RemoveSingleQuotes(txtCCPhrase.Trim) + "' or "
            S = S + " CC like '" + UTIL.RemoveSingleQuotes(txtCCPhrase.Trim) + "' or "
            S = S + " BCC like '" + UTIL.RemoveSingleQuotes(txtCCPhrase.Trim) + "') " + vbCrLf
        End If

        If cbDateSelection.Trim <> "OFF" Then
            Dim bAddParens As Boolean = False
            Dim DateQry As String = ""
            Dim TempDateQry As String = ""
            DbColName$ = "SentOn"
            Dim StartDate$ = dtMailDateStart
            Dim EndDate$ = dtMailDateEnd
            Dim Evaluator$ = cbDateSelection.Trim
            If Not Evaluator$.Equals("OFF") Then
                TempDateQry$ = DMA.ckQryDate(StartDate, EndDate, Evaluator, DbColName, FirstTime)
                bAddParens = True
                '** WDM Modified on 3/10/2010
                bAddParens = False
                DateQry += TempDateQry$
            End If

            'If ckCreationDate.Equals("True") Then
            '    DbColName$ = "CreationTime"
            '    Dim StartDate$ = dtMailDateStart
            '    Dim EndDate$ = dtMailDateEnd
            '    Dim Evaluator$ = cbDateSelection.Trim
            '    If Not Evaluator$.Equals("OFF") Then
            '        'S += DMA.ckQryDate(StartDate, EndDate, Evaluator, DbColName, FirstTime)
            '        TempDateQry$ = DMA.ckQryDate(StartDate, EndDate, Evaluator, DbColName, FirstTime)
            '        bAddParens = True
            '        '** WDM Modified on 3/10/2010
            '        bAddParens = False
            '        DateQry += TempDateQry$
            '    End If
            'End If
            'If ckReceivedTime.Equals("True") Then
            '    DbColName$ = "ReceivedTime"
            '    Dim StartDate$ = dtMailDateStart
            '    Dim EndDate$ = dtMailDateEnd
            '    Dim Evaluator$ = cbDateSelection.Trim
            '    If Not Evaluator$.Equals("OFF") Then
            '        'S += DMA.ckQryDate(StartDate, EndDate, Evaluator, DbColName, FirstTime)
            '        TempDateQry$ = DMA.ckQryDate(StartDate, EndDate, Evaluator, DbColName, FirstTime)
            '        bAddParens = True
            '        '** WDM Modified on 3/10/2010
            '        bAddParens = False
            '        DateQry += TempDateQry$
            '    End If
            'End If
            If bAddParens Then
                DateQry = DateQry.Trim
                Dim CH$ = Mid(DateQry, DateQry.Length - 3)
                CH = UCase(CH)
                If CH.Equals("AND") Then
                    DateQry = Mid(DateQry, 1, DateQry.Length - 3)
                End If
                CH$ = Mid(DateQry, DateQry.Length - 2)
                CH = UCase(CH)
                If CH.Equals("OR") Then
                    DateQry = Mid(DateQry, 1, DateQry.Length - 2)
                End If
                S = S + "(" + DateQry + ")"
            Else
                S = S + DateQry
            End If
        End If

        'If S.Length > 0 Then
        '    S = S + S + " AND "
        'End If

        Return S

    End Function

    Function getSearchParmVal(ByVal tKey As String, ByVal ListOfParms As SortedList(Of String, String)) As String
        Dim RetVal As String = ""
        If ListOfParms.ContainsKey(tKey) Then
            RetVal = ListOfParms.Item(tKey)
        End If
        Return RetVal
    End Function

    Function getThesaurusWords(ByRef SecureID As Integer, ByVal ThesaurusList As ArrayList, ByRef ThesaurusWords As ArrayList) As String

        Dim AllWords As String = ""
        Dim ThesaurusName As String = ""

        If gThesauri.Count = 1 Then
            For kk As Integer = 0 To gThesauri.Count - 1
                ThesaurusName$ = gThesauri(kk).ToString
                ThesaurusList.Add(ThesaurusName)
            Next
            ''FrmMDIMain.SB.Text = "Custom thesauri used"
        ElseIf gThesauri.Count > 0 Then
            For kk As Integer = 0 To gThesauri.Count - 1
                ThesaurusName$ = gThesauri(kk).ToString
                ThesaurusList.Add(ThesaurusName)
            Next
            ''FrmMDIMain.SB.Text = "Custom thesauri used"
        End If

        Dim ListOfPhrases As String = ""
        Dim ExpandedWords As New ArrayList

        If ThesaurusList.Count = 0 Then
            ThesaurusList.Add("Roget")
            ''** Get and use the default Thesaurus'
            ''me.getSystemParm("Default Thesaurus", ThesaurusName)
            'If ThesaurusName$.Equals("NA") Then
            '    Return ""
            'Else
            '    ThesaurusList.Add("Roget")
            'End If
        End If

        '** Get and use the default Thesaurus
        Dim TREX As New clsDb
        For Each T As String In ThesaurusList
            ThesaurusName$ = T
            Dim ThesaurusID As String = TREX.getThesaurusID(SecureID, ThesaurusName)
            For Each token As String In ThesaurusWords
                If Not ExpandedWords.Contains(token) Then
                    ExpandedWords.Add(token)
                End If
                TREX.getSynonyms(SecureID, ThesaurusID, token, ExpandedWords, True)
            Next
        Next
        TREX = Nothing

        For Each SS As String In ExpandedWords
            Dim tWord$ = SS
            tWord = tWord.Trim
            If InStr(tWord, Chr(34)) = 0 Then
                tWord = Chr(34) + tWord + Chr(34)
            End If
            ListOfPhrases$ = ListOfPhrases$ + Chr(9) + tWord + " or " + vbCrLf
        Next
        If ListOfPhrases$ = Nothing Then
            Return ""
        Else
            ListOfPhrases$ = ListOfPhrases$.Trim
            ListOfPhrases$ = Mid(ListOfPhrases$, 1, ListOfPhrases$.Length - 3)
            Return ListOfPhrases$
        End If

    End Function

    Sub RemoveFreetextStopWords(ByRef SecureID As Integer, ByRef SearchPhrase As String)

        SearchPhrase$ = SearchPhrase$.Trim
        If SearchPhrase$.Trim.Length = 0 Then
            Return
        End If

        Dim DB As New clsDatabaseSVR
        Dim AL As New ArrayList
        DB.DBGetSkipWords(SecureID, AL)

        For i As Integer = 1 To SearchPhrase$.Length
            Dim CH$ = Mid(SearchPhrase$, i, 1)
            If CH$ = Chr(34) Then
                Mid(SearchPhrase$, i, 1) = " "
            End If
        Next
        Dim NewPhrase As String = ""
        Dim A$() = SearchPhrase$.Split(" ")
        For i As Integer = 0 To UBound(A)
            Dim tWord$ = A(i).Trim
            Dim TempWord$ = tWord
            tWord = tWord.ToUpper
            If tWord.Length > 0 Then
                If AL.Contains(tWord) Then
                    A(i) = ""
                Else
                    A(i) = TempWord
                End If
            End If
        Next
        NewPhrase = ""
        For i As Integer = 0 To UBound(A)
            If A(i).Trim.Length > 0 Then
                NewPhrase$ = NewPhrase$ + " " + A(i)
            End If
        Next
        SearchPhrase = NewPhrase$
        DB = Nothing
        GC.Collect()
        GC.WaitForPendingFinalizers()
    End Sub

    Function PopulateThesaurusList(ByRef SecureID As Integer, ByVal ThesaurusList As ArrayList, ByRef ThesaurusWords As ArrayList, ByVal txtThesaurus As String, ByVal cbThesaurusText As String) As String

        Dim A1$(0)
        Dim A2$(0)
        Dim Token As String = ""
        Dim ExpandedWords As String = ""

        If InStr(1, txtThesaurus, ",") > 0 Then
            A1 = txtThesaurus.Split(",")
        Else
            A1(0) = txtThesaurus
        End If

        For i As Integer = 0 To UBound(A1)
            Token = A1(i).Trim
            If InStr(Token, Chr(34)) > 0 Then
                ThesaurusWords.Add(Token)
            Else
                A2 = Token.Split(" ")
                For ii As Integer = 0 To UBound(A2)
                    ThesaurusWords.Add(A2(ii).Trim)
                Next
            End If

        Next

        ExpandedWords$ = getThesaurusWords(SecureID, ThesaurusList, ThesaurusWords)

        Return ExpandedWords$

    End Function

    Function GenerateEmailAttachmentSQL(ByRef SearchParmList As SortedList(Of String, String),
                                             ByVal UserID As String, ByVal SearchParms As List(Of DS_SearchTerms),
                                             ByRef SecureID As Integer, ByVal InputSearchString As String,
                                            ByVal useFreetext As Boolean,
                                            ByVal ckWeights As Boolean,
                                            ByVal isEmail As Boolean,
                                            ByVal LimitToCurrRecs As Boolean,
                                            ByVal ThesaurusList As ArrayList,
                                            ByVal txtThesaurus As String,
                                            ByVal cbThesaurusText As String, ByVal calledBy As String) As String

        Dim ContainsClause As String = genContainsClause(SearchParmList, SecureID, "EMAIL")

        Dim bSuperAdmin As Boolean = False
        Dim bAdmin As Boolean = False
        Dim CurrUserGuidID As String = ""

        UTIL.getSearchParmList("CurrUserGuidID", CurrUserGuidID, SearchParmList)
        UTIL.getSearchParmList("isSuperAdmin", bSuperAdmin, SearchParmList)
        UTIL.getSearchParmList("isAdmin", bAdmin, SearchParmList)

        Dim tSql As String = ""
        Dim S As String = ""
        Dim I As Integer = 0

        Try
            tSql = "insert EmailAttachmentSearchList ([UserID],[EmailGuid], RowID) " + vbCrLf
            tSql = tSql + " select '" + UserID + "',[EmailGuid], RowID  " + vbCrLf

            If Not bSuperAdmin And Not bAdmin Then
                Dim JoinStr As String = genInnerJoin("A", UserID)
                JoinStr = JoinStr + " /* A0025 */" + vbCrLf
                tSql += JoinStr
            Else
                tSql = tSql + "FROM EmailAttachment " + vbCrLf
            End If

            tSql = tSql + "where " + vbCrLf
            S$ = ContainsClause$
            I = 0
            I = InStr(S, "(")
            Mid(ContainsClause, I, 1) = " "
            S = S.Trim
            I = InStr(S, ",")
            S = Mid(S, I)
            I = InStr(S, "/*")
            If I > 0 Then
                S = Mid(S, 1, I - 1)
            End If
            If useFreetext Then
                S = "FREETEXT ((Body, SUBJECT, KeyWords, Description)" + S
            Else
                S = "contains(EmailAttachment.*" + S
            End If

            ContainsClause$ = tSql + S + vbCrLf
        Catch ex As Exception
            Console.WriteLine(ex.Message)
        End Try
        tSql = ContainsClause$
        Return tSql
    End Function

    Function isKeyWord(ByRef SecureID As Integer, ByVal KW As String) As Boolean
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
            Case "AND"
                Return True
            Case "FORMSOF"
                Return True
        End Select
        Return B
    End Function

    Function isDelimeter(ByVal KW As String) As Boolean
        Dim B As Boolean = False
        KW = UCase(KW)
        Select Case KW
            Case "("
                Return True
            Case ")"
                Return True
            Case ","
                Return True
        End Select
        Return B
    End Function

    Function getNextChar(ByRef SecureID As Integer, ByVal S As String, ByVal i As Integer) As String
        Dim CH As String = ""
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

    Function getNextToken(ByRef SecureID As Integer, ByVal S As String, ByRef I As Integer, ByRef ReturnedDelimiter As String) As String
        Dim Delimiters As String = " ,:+-^|()"
        S = S.Trim
        Dim Token As String = ""
        Dim CH As String = ""
        CH = Mid(S, I, 1)
        Dim KK As Integer = S.Length

        '** If CH is a blank char, skip to the start of the next token
        If CH = " " Then
            Do Until (CH <> " " And I <= KK)
                I += 1
                CH = Mid(S, I, 1)
            Loop
        End If

        If CH = Chr(34) Then
            Token = ""
            Token += Chr(34)
            I += 1
            CH = Mid(S, I, 1)
            KK = S.Length
            Do Until (CH = Chr(34) And I <= KK)
                Token += CH
                I += 1
                CH = Mid(S, I, 1)
                If I > S.Length Then
                    Exit Do
                End If
            Loop
            Token += Chr(34)
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

    Function getTheRestOfTheToken(ByRef SecureID As Integer, ByVal S As String, ByRef I As Integer) As String
        'We are sitting at the next character in the token, so go back to the beginning
        I = I - 1
        Dim Delimiters As String = " ,:+-^|"
        S = S.Trim
        Dim Token As String = ""
        Dim CH As String = ""
        CH = Mid(S, I, 1)
        Dim KK As Integer = S.Length

        '** If CH is a blank char, skip to the start of the next token
        If CH = " " Then
            Do Until (CH <> " " And I <= KK)
                I += 1
                CH = Mid(S, I, 1)
            Loop
        End If

        If CH = Chr(34) Then
            Token = ""
            Token += Chr(34)
            I += 1
            CH = Mid(S, I, 1)
            KK = S.Length
            Do Until (CH = Chr(34) And I <= KK)
                Token += CH
                I += 1
                CH = Mid(S, I, 1)
                If I > S.Length Then
                    Exit Do
                End If
            Loop
            Token += Chr(34)
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

    Function ValidateContainsList(ByRef SecureID As Integer, ByRef ContainsList As String) As Boolean
        ContainsList$ = ContainsList$.Trim
        If ContainsList.Trim.Length = 0 Then
            Return False
        End If
        If isKeyWord(SecureID, ContainsList) Then
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

    Function QuotesRequired(ByVal DataType As String) As Boolean
        Dim B As Boolean = False
        DataType = UCase(DataType)

        Select Case DataType
            Case "INT"
                Return False
            Case "DATETIME"
                Return True
            Case "DECIMAL"
                Return False
            Case "FLOAT"
                Return False
            Case "VARCHAR"
                Return True
            Case "NVARCHAR"
                Return True
            Case "CHAR"
                Return True
            Case "NCHAR"
                Return True
            Case Else
                B = True
        End Select
        Return B
    End Function

    Sub IncludeEmailAttachmentsSearch(ByVal SearchParmList As SortedList(Of String, String), ByRef SecureID As Integer, ByVal UID As String, ByVal ckIncludeAttachments As Boolean, _
                                        ByVal ckWeights As Boolean, _
                                        ByVal ckBusiness As Boolean, _
                                        ByVal SearchText As String, _
                                        ByVal ckLimitToExisting As Boolean, _
                                        ByVal txtThesaurus As String, _
                                        ByVal cbThesaurusText As String, _
                                        ByVal LibraryName As String, ByVal bIncludeAllLibs As Boolean, bAdmin As Boolean, bGlobalSearcher As Boolean)

        Dim DB As New clsDatabaseSVR
        Dim useFreetext As Boolean = False
        Dim ContainsClause As String = genContainsClause(SearchParmList, SecureID, "EMAIL")

        Dim CurrUserGuidID As String = ""

        UTIL.getSearchParmList("CurrUserGuidID", CurrUserGuidID, SearchParmList)

        If ckIncludeAttachments Then

            If bIncludeAllLibs = True Then
                LibraryName = ""
            End If

            Dim SS$ = "delete FROM [EmailAttachmentSearchList] where [UserID] = '" + UID + "'"
            Dim BB As Boolean = DB.DBExecuteSql(SecureID, SS)
            If Not BB Then
                MsgBox("Failed to initialize Attachment Content Search. Content search is not included in the results.")
            Else

                Dim tSql As String = ""
                Dim S As String = ""
                Dim I As Integer = 0

                Try
                    tSql = "insert EmailAttachmentSearchList ([UserID],[EmailGuid], RowID) " + vbCrLf
                    tSql = tSql + " select '" + UID + "',[EmailGuid], RowID  " + vbCrLf

                    If Not bGlobalSearcher And Not bAdmin Then
                        Dim JoinStr As String = genInnerJoin("A", UID)
                        JoinStr = JoinStr + " /* A0025 */" + vbCrLf
                        tSql += JoinStr
                    Else
                        tSql = tSql + "FROM EmailAttachment " + vbCrLf
                    End If

                    tSql = tSql + "where " + vbCrLf
                    S$ = ContainsClause$
                    I = 0
                    I = InStr(S, "(")
                    Mid(ContainsClause, I, 1) = " "
                    S = S.Trim
                    I = InStr(S, ",")
                    S = Mid(S, I)
                    I = InStr(S, "/*")
                    If I > 0 Then
                        S = Mid(S, 1, I - 1)
                    End If
                    If useFreetext Then
                        S = "FREETEXT ((Body, SUBJECT, KeyWords, Description)" + S
                    Else
                        S = "contains(EmailAttachment.*" + S
                    End If

                    ContainsClause$ = tSql + S + vbCrLf
                Catch ex As Exception
                    Console.WriteLine(ex.Message)
                End Try
                tSql = ContainsClause$

                BB = DB.DBExecuteSql(SecureID, tSql, False)

                If Not BB Then
                    DB.DBLogMessage(SecureID, gCurrUserGuidID, "clsGenerator:IncludeEmailAttachmentsSearch : Failed to insert Attachment Content Search. Content search is not included in the results.")
                    DB.DBLogMessage(SecureID, gCurrUserGuidID, "clsGenerator:IncludeEmailAttachmentsSearch : The SQL Stmt: " + tSql)
                    NbrOfErrors += 1
                    ''FrmMDIMain.SB.Text = "Errors: " + NbrOfErrors.ToString
                End If

            End If
        End If

        DB = Nothing
        GC.Collect()
        GC.WaitForPendingFinalizers()

    End Sub

    Function SearchEmailAttachments(ByRef SecureID As Integer, ByVal UID As String, ByVal isFreetext As Boolean, isAdmin As Boolean, isGlobalSearcher As Boolean) As String

        Dim InsertSQL As String = ""

        Dim DB As New clsDatabaseSVR

        Dim S As String = ""
        Dim I As Integer = 0

        S = "delete from EmailAttachmentSearchList where UserID = '" + UID + "' "
        Dim B As Boolean = DB.DBExecuteSql(SecureID, S)
        If B = False Then
            DB.DBLogMessage(SecureID, gCurrUserGuidID, "Notice: Failed to delete user records from EmailAttachmentSearchList.")
        End If

        Try

            InsertSQL = "insert EmailAttachmentSearchList ([UserID],[EmailGuid], RowID) " + vbCrLf
            InsertSQL = InsertSQL + " select '" + UID + "',[EmailGuid], RowID  " + vbCrLf

            If Not isAdmin And Not isGlobalSearcher Then
                Dim JoinStr As String = genInnerJoin("A", UID)
                JoinStr += JoinStr + " /*  A0022 */"
                InsertSQL = InsertSQL + vbCrLf + JoinStr + vbCrLf
            Else
                InsertSQL = InsertSQL + " FROM EmailAttachment " + vbCrLf
            End If

            InsertSQL = InsertSQL + " where " + vbCrLf
            S = InsertSQL
            I = 0
            I = InStr(S, "(")
            Mid(InsertSQL, I, 1) = " "
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

            InsertSQL = InsertSQL + S + vbCrLf
        Catch ex As Exception
            Console.WriteLine(ex.Message)
        End Try

        DB = Nothing
        GC.Collect()
        GC.WaitForPendingFinalizers()
        Return InsertSQL

    End Function

    Function isNotDelimiter(ByRef SecureID As Integer, ByVal CH As String) As Boolean
        Dim Alphabet$ = " |+-^"
        If InStr(1, Alphabet, CH) = 0 Then
            Return True
        Else
            Return False
        End If
    End Function
    Function isDelimiter(ByRef SecureID As Integer, ByVal CH As String) As Boolean
        Dim Alphabet$ = " |+-^"
        If InStr(1, Alphabet, CH) > 0 Then
            Return True
        Else
            Return False
        End If
    End Function
    Function isSyntaxChar(ByRef SecureID As Integer, ByVal CH As String) As Boolean
        Dim Alphabet$ = "#|+-^~"
        If InStr(1, Alphabet, CH) > 0 Then
            Return True
        Else
            Return False
        End If
    End Function

    Sub GetQuotedString(ByRef SecureID As Integer, ByVal tstr As String, ByRef i As Integer, ByRef j As Integer, ByRef QuotedString As String)
        Dim X As Integer = tstr.Trim.Length
        Dim Q$ = Chr(34)
        Dim CH As String = ""
        Dim Alphabet$ = " |+-^"
        Dim S As String = ""
        QuotedString$ = Q
        i += 1
        CH = Mid(tstr, i, 1)
        Do While CH <> Chr(34) And i <= tstr.Length
            QuotedString$ = QuotedString$ + CH
            i += 1
            CH = Mid(tstr, i, 1)
        Loop
        QuotedString$ = QuotedString$ + Q
    End Sub

    Sub SkipTokens(ByRef SecureID As Integer, ByVal tstr As String, ByVal i As Integer, ByRef j As Integer)
        Dim X As Integer = tstr.Trim.Length
        Dim Q$ = Chr(34)
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

    Sub SubIn(ByRef SecureID As Integer, ByRef ParentString As String, ByVal WhatToChange As String, ByVal ChangeCharsToThis As String)
        Dim I As Integer = 0
        Dim J As Integer = 0
        Dim M As Integer = 0
        Dim N As Integer = 0
        Dim S1 As String = ""
        Dim S2 As String = ""

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

    Private Function genInnerJoin(ContentTypeCode As String, ContentUserID As String) As String

        ContentTypeCode = ContentTypeCode.ToUpper
        Dim TempStr As String = ""

        If ContentTypeCode.ToUpper.Equals("C") Then
            TempStr = " FROM DataSource " + vbCrLf
            TempStr = "      INNER JOIN" + vbCrLf
            TempStr += "       ContentUser ON DataSource.DataSourceOwnerUserID = ContentUser.UserID AND DataSource.SourceGuid = ContentUser.ContentGuid " + vbCrLf
            TempStr += "       AND ContentUser.ContentTypeCode = 'C'" + vbCrLf
            TempStr += "       AND ContentUser.UserID = '" + ContentUserID + "'" + vbCrLf
            'GROUP BY DataSource.RowGuid, ContentUser.ContentUserRowGuid, ContentUser.NbrOccurances, ContentUser.ContentTypeCode, ContentUser.ContentGuid, ContentUser.UserID
        ElseIf ContentTypeCode.ToUpper.Equals("E") Then
            TempStr += " FROM       Email INNER JOIN" + vbCrLf
            TempStr += " ContentUser ON ContentUser.ContentGuid = Email.EmailGuid" + vbCrLf
            TempStr += " AND ContentUser.ContentTypeCode = 'E'" + vbCrLf
            TempStr += "       AND ContentUser.UserID = '" + ContentUserID + "'" + vbCrLf
            'GROUP BY ContentUser.ContentUserRowGuid, ContentUser.NbrOccurances, ContentUser.ContentTypeCode, ContentUser.ContentGuid, ContentUser.UserID
        ElseIf ContentTypeCode.ToUpper.Equals("A") Then
            TempStr += " FROM       EmailAttachment INNER JOIN"
            TempStr += " ContentUser ON ContentUser.ContentGuid = EmailAttachment.EmailGuid "
            TempStr += " AND ContentUser.ContentTypeCode = 'A' "
            TempStr += "       AND ContentUser.UserID = '" + ContentUserID + "'" + vbCrLf
            'GROUP BY ContentUser.ContentUserRowGuid, ContentUser.NbrOccurances, ContentUser.ContentTypeCode, ContentUser.ContentGuid, ContentUser.UserID, EmailAttachment.AttachmentName
        End If

        Return TempStr

    End Function

End Class