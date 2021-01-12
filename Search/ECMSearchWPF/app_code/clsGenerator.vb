' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 12-15-2020
'
' Last Modified By : wdale
' Last Modified On : 12-15-2020
' ***********************************************************************
' <copyright file="clsGenerator.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
Imports System.IO
Imports ECMEncryption
'Imports System.Data.SqlClient

''' <summary>
''' Class clsGenerator.
''' </summary>
Public Class clsGenerator


    ''' <summary>
    ''' The top rows
    ''' </summary>
    Public TopRows As Integer = 0
    ''' <summary>
    ''' The use weights
    ''' </summary>
    Public UseWeights As Boolean = False
    ''' <summary>
    ''' The sort order
    ''' </summary>
    Private SortOrder As String = ""

    ''' <summary>
    ''' Gens the doc paging by row header.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Function genDocPagingByRowHeader() As String

        Dim S As String = " WITH xContent AS (" + vbCrLf
        Return S

    End Function

    ''' <summary>
    ''' Gens the doc paging by row footer.
    ''' </summary>
    ''' <param name="StartNbr">The start NBR.</param>
    ''' <param name="EndNbr">The end NBR.</param>
    ''' <returns>System.String.</returns>
    Function genDocPagingByRowFooter(ByVal StartNbr As Integer, ByVal EndNbr As Integer) As String

        Dim S As String = ""
        S = S + " )" + vbCrLf
        S = S + " SELECT * FROM xContent" + vbCrLf
        S = S + " WHERE ROWID BETWEEN " + StartNbr.ToString + " AND " + EndNbr.ToString + vbCrLf
        Return S

    End Function

    ''' <summary>
    ''' Docs the search meta data.
    ''' </summary>
    ''' <param name="MetaDataName">Name of the meta data.</param>
    ''' <param name="MetaDataValue">The meta data value.</param>
    ''' <param name="Mandatory">if set to <c>true</c> [mandatory].</param>
    ''' <returns>System.String.</returns>
    Function DocSearchMetaData(ByVal MetaDataName As String, ByVal MetaDataValue As String, ByVal Mandatory As Boolean) As String

        If MetaDataValue.Length = 0 Then
            Return String.Empty
        ElseIf MetaDataName.Length = 0 Then
            Return String.Empty
        End If

        MetaDataValue$ = FixSingleQuote(MetaDataValue)

        Dim S As String = ""
        Dim CH$ = ""
        Dim WhereClause$ = ""
        'Dim MetaDataType$ = DB.getAttributeDataType(MetaDataName  )
        'Dim QuotesNeeded As Boolean = DB.QuotesRequired(MetaDataType  )

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


    ''' <summary>
    ''' Documents the search created within last x days.
    ''' </summary>
    ''' <param name="ckLimitTodays">if set to <c>true</c> [ck limit todays].</param>
    ''' <param name="DaysOld">The days old.</param>
    ''' <param name="Mandatory">if set to <c>true</c> [mandatory].</param>
    ''' <returns>System.String.</returns>
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

    ''' <summary>
    ''' Documents the search limit to current guids.
    ''' </summary>
    ''' <param name="CurrUserID">The curr user identifier.</param>
    ''' <param name="ckLimitToExisting">if set to <c>true</c> [ck limit to existing].</param>
    ''' <param name="CurrentGuids">The current guids.</param>
    ''' <returns>System.String.</returns>
    Function DocSearchLimitToCurrentGuids(ByVal CurrUserID As String, ByVal ckLimitToExisting As Boolean, ByVal CurrentGuids As List(Of String)) As String
        Dim S As String = ""
        If ckLimitToExisting Then
            'DB.LimitToExistingRecs(CurrentGuids)
            S = " AND (SourceGuid in (SELECT [DocGuid] FROM ActiveSearchGuids where  UserID = '" + CurrUserID + "'))"
        End If
        Return S
    End Function

    ''' <summary>
    ''' Documents the search create date.
    ''' </summary>
    ''' <param name="ckDate">if set to <c>true</c> [ck date].</param>
    ''' <param name="DATECODE">The datecode.</param>
    ''' <param name="Mandatory">if set to <c>true</c> [mandatory].</param>
    ''' <param name="bReceived">if set to <c>true</c> [b received].</param>
    ''' <param name="bCreated">if set to <c>true</c> [b created].</param>
    ''' <param name="Startdate">The startdate.</param>
    ''' <param name="EndDate">The end date.</param>
    ''' <returns>System.String.</returns>
    Function DocSearchCreateDate(ByVal ckDate As Boolean,
                           ByVal DATECODE As String,
                           ByVal Mandatory As Boolean,
                           ByVal bReceived As Boolean,
                           ByVal bCreated As Boolean,
                           ByVal Startdate As Date,
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

    ''' <summary>
    ''' Documents the search date last write time.
    ''' </summary>
    ''' <param name="ckDate">if set to <c>true</c> [ck date].</param>
    ''' <param name="DATECODE">The datecode.</param>
    ''' <param name="Mandatory">if set to <c>true</c> [mandatory].</param>
    ''' <param name="bReceived">if set to <c>true</c> [b received].</param>
    ''' <param name="bCreated">if set to <c>true</c> [b created].</param>
    ''' <param name="Startdate">The startdate.</param>
    ''' <param name="EndDate">The end date.</param>
    ''' <returns>System.String.</returns>
    Function DocSearchDateLastWriteTime(ByVal ckDate As Boolean,
                           ByVal DATECODE As String,
                           ByVal Mandatory As Boolean,
                           ByVal bReceived As Boolean,
                           ByVal bCreated As Boolean,
                           ByVal Startdate As Date,
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


    ''' <summary>
    ''' Documents the search file directory.
    ''' </summary>
    ''' <param name="FileDirectory">The file directory.</param>
    ''' <param name="Mandatory">if set to <c>true</c> [mandatory].</param>
    ''' <returns>System.String.</returns>
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

    ''' <summary>
    ''' Searches the by minimum weight.
    ''' </summary>
    ''' <param name="MinWeight">The minimum weight.</param>
    ''' <param name="SetWeight">if set to <c>true</c> [set weight].</param>
    ''' <returns>System.String.</returns>
    Function SearchByMinWeight(ByVal MinWeight As String, ByVal SetWeight As Boolean) As String

        If SetWeight = False Then
            Return String.Empty
        End If

        Dim S As String = String.Empty
        S += " and KEY_TBL.RANK >= " + MinWeight + vbCrLf

        Return S
    End Function

    ''' <summary>
    ''' Documents the search by file ext.
    ''' </summary>
    ''' <param name="EXT">The ext.</param>
    ''' <param name="Mandatory">if set to <c>true</c> [mandatory].</param>
    ''' <returns>System.String.</returns>
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

    ''' <summary>
    ''' Documents the name of the search by file.
    ''' </summary>
    ''' <param name="FQN">The FQN.</param>
    ''' <param name="Mandatory">if set to <c>true</c> [mandatory].</param>
    ''' <returns>System.String.</returns>
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

    ''' <summary>
    ''' Documents the search order by weights.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Function DocSearchOrderByWeights() As String
        Dim S As String = String.Empty
        S = " and KEY_TBL.RANK >= 0 ORDER BY KEY_TBL.RANK DESC "
        Return S
    End Function

    ''' <summary>
    ''' Documents the search gen cols.
    ''' </summary>
    ''' <param name="ckWeighted">if set to <c>true</c> [ck weighted].</param>
    ''' <param name="searchCriteria">The search criteria.</param>
    ''' <returns>System.String.</returns>
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
            S += vbTab + ",DS.DataSourceOwnerUserID, DS.FileDirectory, DS.RetentionExpirationDate, DS.isMaster, DS.StructuredData, DS.RepoSvrName " + vbCrLf
            S += "FROM DataSource as DS " + vbCrLf

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
            S += vbTab + ",[DataSourceOwnerUserID], FileDirectory, RetentionExpirationDate, isMaster, StructuredData, RepoSvrName " + vbCrLf
            S += "FROM DataSource " + vbCrLf
            'If bSaveToClipBoard Then
            'Clipboard.SetText(s)
            'End If
        End If

        Return S

    End Function

    ''' <summary>
    ''' Documents the search gen cols paging.
    ''' </summary>
    ''' <param name="ckWeighted">if set to <c>true</c> [ck weighted].</param>
    ''' <param name="searchCriteria">The search criteria.</param>
    ''' <returns>System.String.</returns>
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
            S += vbTab + ",DS.StructuredData" + vbCrLf
            S += vbTab + ",ROW_NUMBER() OVER (ORDER BY SourceName ASC) AS ROWID, RepoSvrName  )" + vbCrLf
            S += "FROM DataSource as DS " + vbCrLf

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
            S += vbTab + ", StructuredData " + vbCrLf
            S += vbTab + ",ROW_NUMBER() OVER (ORDER BY SourceName ASC) AS ROWID, RepoSvrName  " + vbCrLf
            S += "FROM DataSource " + vbCrLf
            'If bSaveToClipBoard Then
            'Clipboard.SetText(s)
            'End If
        End If

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
        Dim SearchStr As String = SearchText
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
                'Token = chrw(34) + Token
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
                    Console.WriteLine("Should not be here.")
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
                End If
            End If
        Next

        Return S
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
    ''' Emails the search within last x days.
    ''' </summary>
    ''' <param name="DaysOld">The days old.</param>
    ''' <param name="SetWeight">if set to <c>true</c> [set weight].</param>
    ''' <returns>System.String.</returns>
    Function EmailSearchWithinLastXDays(ByVal DaysOld As String, ByVal SetWeight As Boolean) As String
        If SetWeight = False Then
            Return String.Empty
        End If

        Dim S As String = String.Empty
        S += " and (CreationTime >= GETDATE() - " + DaysOld + " or SentOn  >= GETDATE() - " + DaysOld.ToString + " )"

        Return S
    End Function


    ''' <summary>
    ''' Emails the search all receipients.
    ''' </summary>
    ''' <param name="Name">The name.</param>
    ''' <param name="Mandatory">if set to <c>true</c> [mandatory].</param>
    ''' <returns>System.String.</returns>
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

        S = S + " (AllRecipients like '" + FixSingleQuote(Name) + "' or " + vbCrLf
        S = S + "      CC like '" + FixSingleQuote(Name) + "' or " + vbCrLf
        S = S + "      BCC like '" + FixSingleQuote(Name) + "') " + vbCrLf

        Return S
    End Function

    ''' <summary>
    ''' Emails the search my emails only.
    ''' </summary>
    ''' <param name="CurrUserID">The curr user identifier.</param>
    ''' <param name="bLimitReturn">if set to <c>true</c> [b limit return].</param>
    ''' <param name="isGlobalSearcher">if set to <c>true</c> [is global searcher].</param>
    ''' <returns>System.String.</returns>
    Function EmailSearchMyEmailsOnly(ByVal CurrUserID As String, ByVal bLimitReturn As Boolean, ByVal isGlobalSearcher As Boolean) As String

        Dim S As String = String.Empty

        If isGlobalSearcher = False Then
            S += " AND (where UserID = '" + CurrUserID + "' or isPublic = 'Y' )"
            Return S
        End If

        If bLimitReturn = False Then
            Return String.Empty
        End If

        S += " AND (where UserID = '" + CurrUserID + "' or isPublic = 'Y' )"

        Return S
    End Function

    ''' <summary>
    ''' Emails the search cc BCC.
    ''' </summary>
    ''' <param name="Name">The name.</param>
    ''' <param name="Mandatory">if set to <c>true</c> [mandatory].</param>
    ''' <returns>System.String.</returns>
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

    ''' <summary>
    ''' Emails the search subject.
    ''' </summary>
    ''' <param name="Name">The name.</param>
    ''' <param name="Mandatory">if set to <c>true</c> [mandatory].</param>
    ''' <returns>System.String.</returns>
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

    ''' <summary>
    ''' Emails the search by folder.
    ''' </summary>
    ''' <param name="Name">The name.</param>
    ''' <param name="Mandatory">if set to <c>true</c> [mandatory].</param>
    ''' <returns>System.String.</returns>
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

    ''' <summary>
    ''' Emails the name of the search received by.
    ''' </summary>
    ''' <param name="Name">The name.</param>
    ''' <param name="Mandatory">if set to <c>true</c> [mandatory].</param>
    ''' <returns>System.String.</returns>
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

    ''' <summary>
    ''' Emails the account.
    ''' </summary>
    ''' <param name="Name">The name.</param>
    ''' <param name="Mandatory">if set to <c>true</c> [mandatory].</param>
    ''' <returns>System.String.</returns>
    Function EmailAccount(ByVal Name As String, ByVal Mandatory As Boolean) As String

        Return EmailSearchReceivedByName(Name, Mandatory)

    End Function

    ''' <summary>
    ''' Emails the name of the search from.
    ''' </summary>
    ''' <param name="Name">The name.</param>
    ''' <param name="Mandatory">if set to <c>true</c> [mandatory].</param>
    ''' <returns>System.String.</returns>
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

    ''' <summary>
    ''' Emails the search to email addr.
    ''' </summary>
    ''' <param name="EmailAddr">The email addr.</param>
    ''' <param name="Mandatory">if set to <c>true</c> [mandatory].</param>
    ''' <returns>System.String.</returns>
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

    ''' <summary>
    ''' Emails the search from email addr.
    ''' </summary>
    ''' <param name="EmailAddr">The email addr.</param>
    ''' <param name="Mandatory">if set to <c>true</c> [mandatory].</param>
    ''' <returns>System.String.</returns>
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

    ''' <summary>
    ''' Emails the search date limits.
    ''' </summary>
    ''' <param name="ckDate">if set to <c>true</c> [ck date].</param>
    ''' <param name="DATECODE">The datecode.</param>
    ''' <param name="Mandatory">if set to <c>true</c> [mandatory].</param>
    ''' <param name="bSent">if set to <c>true</c> [b sent].</param>
    ''' <param name="bReceived">if set to <c>true</c> [b received].</param>
    ''' <param name="bCreated">if set to <c>true</c> [b created].</param>
    ''' <param name="Startdate">The startdate.</param>
    ''' <param name="EndDate">The end date.</param>
    ''' <returns>System.String.</returns>
    Function EmailSearchDateLimits(ByVal ckDate As Boolean,
                           ByVal DATECODE As String,
                           ByVal Mandatory As Boolean,
                           ByVal bSent As Boolean,
                           ByVal bReceived As Boolean,
                           ByVal bCreated As Boolean,
                           ByVal Startdate As Date,
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
    ''' <summary>
    ''' Emails the gen cols no weights.
    ''' </summary>
    ''' <param name="ContainsClause">The contains clause.</param>
    ''' <returns>System.String.</returns>
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

    ''' <summary>
    ''' Emails the gen cols no weights.
    ''' </summary>
    ''' <returns>System.String.</returns>
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

    ''' <summary>
    ''' Gens the new email query.
    ''' </summary>
    ''' <param name="GeneratedSql">The generated SQL.</param>
    Sub genNewEmailQuery(ByRef GeneratedSql As String)
        Dim a$() = GeneratedSql.Split(vbCrLf)
        Dim S As String = ""
        Dim bNextWhereStmt As Boolean = False
        Dim bGenNewSql As Boolean = False
        Dim NewSql$ = ""
        Dim StdQueryCols As String = Me.genStdEmailQqueryCols
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

            'If UseWeights = True Then
            '    S = S + vbTab + "FROM Email as DS "
            '    S = ReplacePrefix(Prefix, "email.", S)
            'Else
            '    S = S + vbTab + "FROM Email "
            'End If

            If InStr(S, "CONTAINS", CompareMethod.Text) > 0 Then
                If Left(S, "CONTAINS".Length).ToUpper.Equals("CONTAINS") Then
                    Dim TempStr$ = RemoveSpaces(S)
                    TempStr$ = TempStr$.ToUpper
                    If InStr(TempStr, "CONTAINS(*", CompareMethod.Text) > 0 Then
                        Dim k As Integer = InStr(S, "*")
                        Dim S1$ = ""
                        Dim S2$ = ""
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

    ''' <summary>
    ''' Gens the new email attachment query.
    ''' </summary>
    ''' <param name="GeneratedSql">The generated SQL.</param>
    Sub genNewEmailAttachmentQuery(ByRef GeneratedSql As String)
        Dim a$() = GeneratedSql.Split(vbCrLf)
        Dim S As String = ""
        Dim bNextWhereStmt As Boolean = False
        Dim bGenNewSql As Boolean = False
        Dim NewSql$ = ""
        Dim StdQueryCols As String = genStdEmailAttachmentQqueryCols()
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
                Dim S1$ = ""
                Dim S2$ = ""
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

    ''' <summary>
    ''' Gens the new document query.
    ''' </summary>
    ''' <param name="GeneratedSql">The generated SQL.</param>
    Sub genNewDocQuery(ByRef GeneratedSql As String)
        Dim a$() = GeneratedSql.Split(vbCrLf)
        Dim S As String = ""
        Dim bNextWhereStmt As Boolean = False
        Dim bGenNewSql As Boolean = False
        Dim NewSql$ = ""
        Dim StdQueryCols As String = genStdDocQueryCols()
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
                        Dim S1$ = ""
                        Dim S2$ = ""
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


    ''' <summary>
    ''' Gens the standard email qquery cols.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Function genStdEmailQqueryCols() As String
        Dim S As String = ""
        Dim Prefix As String = ""
        If TopRows > 0 Then
            S = S + "Select top " + TopRows.ToString + " " + vbCrLf
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
            S = ReplacePrefix(Prefix, "email.", S)
        Else
            S = S + vbTab + "FROM Email "
        End If


        Return S
    End Function

    ''' <summary>
    ''' Gens the standard email attachment qquery cols.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Function genStdEmailAttachmentQqueryCols() As String

        Dim Prefix$ = "DS."
        Dim S As String = ""
        If TopRows > 0 Then
            S = S + "Select top " + TopRows.ToString + " " + vbCrLf
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
            S = ReplacePrefix(Prefix, "EmailAttachment.", S)
        Else
            S = S + vbTab + "FROM EmailAttachment " + vbCrLf
        End If

        Return S
    End Function

    ''' <summary>
    ''' Gens the standard document query cols.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Function genStdDocQueryCols() As String

        Dim Prefix$ = "DS."
        Dim S As String = ""
        If TopRows > 0 Then
            S = S + "Select top " + TopRows.ToString + " " + vbCrLf
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
    ''' <summary>
    ''' Removes the spaces.
    ''' </summary>
    ''' <param name="sText">The s text.</param>
    ''' <returns>System.String.</returns>
    Function RemoveSpaces(ByVal sText As String) As String
        Dim A$() = Split(sText, " + vbcrlf ")
        Dim S As String = ""
        For i As Integer = 0 To UBound(A)
            S = S + A(i)
        Next
        Return S
    End Function

    ''' <summary>
    ''' Replaces the prefix.
    ''' </summary>
    ''' <param name="NewPrefix">Creates new prefix.</param>
    ''' <param name="PrefixToReplace">The prefix to replace.</param>
    ''' <param name="tgtStr">The TGT string.</param>
    ''' <returns>System.String.</returns>
    Function ReplacePrefix(ByVal NewPrefix As String, ByVal PrefixToReplace As String, ByVal tgtStr As String) As String
        Dim NewStr$ = ""
        Dim I As Integer = 0
        Dim J As Integer = 0
        Dim S As String = tgtStr
        Dim S1$ = ""
        Dim S2$ = ""

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

    ''' <summary>
    ''' Replaces the star.
    ''' </summary>
    ''' <param name="tVal">The t value.</param>
    Sub ReplaceStar(ByRef tVal As String)
        Dim CH$ = ""
        If InStr(tVal, "*") = 0 Then
            Return
        End If
        tVal = tVal.Replace("*", "%")
    End Sub

    ''' <summary>
    ''' Fixes the single quote.
    ''' </summary>
    ''' <param name="tVal">The t value.</param>
    ''' <returns>System.String.</returns>
    Public Function FixSingleQuote(ByVal tVal As String) As String

        If InStr(tVal$, "''") > 0 Then
            Return (tVal)
        End If
        If InStr(tVal$, "'") = 0 Then
            Return (tVal)
        End If

        Dim SS As String = tVal
        SS = SS.Replace("'", "''")
        'Try
        '    Dim i As Integer = Len(tVal)
        '    Dim ch As String = ""
        '    Dim NewStr$ = ""
        '    Dim S1$ = ""
        '    Dim S2$ = ""
        '    Dim A$()
        '    Dim PrevCH$ = "@"
        '    i = InStr(1, tVal, "'")
        '    Do While InStr(1, tVal, "'") > 0
        '        i = InStr(1, tVal, "'")
        '        S1 = Mid(tVal, 1, i)
        '        Mid(S1, S1.Length, 1) = ChrW(254)
        '        S2 = ChrW(254) + Mid(tVal, i + 1)
        '        tVal$ = S1 + S2
        '    Loop

        '    For i = 1 To Len(tVal)
        '        ch = Mid(tVal, i, 1)
        '        If ch = ChrW(254) Then
        '            Mid(tVal, i, 1) = "'"
        '        End If
        '    Next
        'Catch ex As Exception
        '    WriteToLog("ERROR: FixSingleQuote - " + ex.Message + vbCrLf + ex.StackTrace)
        'End Try

        Return SS
    End Function

    ''' <summary>
    ''' Writes to log.
    ''' </summary>
    ''' <param name="Msg">The MSG.</param>
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
            'Debug.Print(Token)
            If I > S.Length Then
                Exit Do
            End If
        Loop
    End Sub

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
    ''' Gens the library search.
    ''' </summary>
    ''' <param name="CurrUserID">The curr user identifier.</param>
    ''' <param name="bSourceSearch">if set to <c>true</c> [b source search].</param>
    ''' <param name="bGlobalSearcher">if set to <c>true</c> [b global searcher].</param>
    ''' <param name="LocationID">The location identifier.</param>
    ''' <returns>System.String.</returns>
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
                'S = S + " AND (UserID IS NOT NULL" + chrw(9) + chrw(9) + " /*KEEP*/" + vbCrLf
                'S = S + chrw(9) + " or isPublic = 'Y'" + " /*KEEP*/" + vbCrLf
                S = S + ChrW(9) + "/* This is where the library search would go - you have global rights, think about it.*/" + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
                S = S + ChrW(9) + " AND (UserID IS NOT NULL)" + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
                Return S
            Else
                S = S + " AND (UserID = '" + CurrUserID + "'" + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
                S = S + ChrW(9) + " or isPublic = 'Y'" + " /*KEEP*/" + vbCrLf
            End If
        End If
        If SearchCode.Equals("S") Or SearchCode.Equals("EMAIL") Then
            If bGlobalSearcher = True Then
                'S = S + " AND (DataSourceOwnerUserID IS NOT NULL" + chrw(9) + chrw(9) + " /*KEEP*/" + vbCrLf
                'S = S + chrw(9) + " or isPublic = 'Y'" + " /*KEEP*/" + vbCrLf
                S = S + ChrW(9) + "/* This is where the library search would go - you have global rights, think about it.*/" + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
                S = S + ChrW(9) + " AND (DataSourceOwnerUserID IS NOT NULL)" + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
                Return S
            Else
                S = S + " AND (DataSourceOwnerUserID = '" + CurrUserID + "'" + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
                S = S + ChrW(9) + " or isPublic = 'Y'" + " /*KEEP*/" + vbCrLf
            End If
        End If

        's=s+ chrw(9) + " SELECT GroupUsers.GroupName, Library.LibraryName, LibraryUsers.UserID, LibraryItems.SourceGuid" + chrw(9) + chrw(9) + " /*KEEP*/" + vbCrLf
        S = S + ChrW(9) + ChrW(9) + " /* GENID:" + LocationID + "*/" + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
        If SearchCode.Equals("E") Or SearchCode.Equals("EMAIL") Then
            S = S + ChrW(9) + ChrW(9) + " or EmailGuid in (" + " /*KEEP*/" + vbCrLf
        Else
            S = S + ChrW(9) + ChrW(9) + " or SourceGuid in (" + " /*KEEP*/" + vbCrLf
        End If

        S = S + ChrW(9) + " SELECT LibraryItems.SourceGuid" + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
        S = S + ChrW(9) + " FROM   LibraryItems INNER JOIN" + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
        S = S + ChrW(9) + "        Library ON LibraryItems.LibraryName = Library.LibraryName INNER JOIN" + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
        S = S + ChrW(9) + "        LibraryUsers ON Library.LibraryName = LibraryUsers.LibraryName INNER JOIN" + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
        S = S + ChrW(9) + "        GroupLibraryAccess ON Library.LibraryName = GroupLibraryAccess.LibraryName INNER JOIN" + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
        S = S + ChrW(9) + "        GroupUsers ON GroupLibraryAccess.GroupName = GroupUsers.GroupName" + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
        S = S + ChrW(9) + " where " + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
        S = S + ChrW(9) + "        libraryusers.userid ='" + CurrUserID + "' " + ChrW(9) + ChrW(9) + " /*KEEP*/   /*ID55*/" + vbCrLf

        S = S + ChrW(9) + "UNION " + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
        S = S + ChrW(9) + "Select LI.SourceGuid" + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
        S = S + ChrW(9) + "FROM         LibraryItems AS LI INNER JOIN" + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
        S = S + ChrW(9) + "             LibraryUsers AS LU ON LI.LibraryName = LU.LibraryName" + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
        S = S + ChrW(9) + "WHERE     (LU.UserID = '" + CurrUserID + "')" + ChrW(9) + ChrW(9) + " /*KEEP*/   /*ID56*/" + vbCrLf

        S = S + ChrW(9) + "))" + " /*KEEP*/" + vbCrLf

        S = S + ChrW(9) + " /* GLOBAL Searcher = " + bGlobalSearcher.ToString + "  */" + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf

        Return S

    End Function

    ''' <summary>
    ''' Gens the library search.
    ''' </summary>
    ''' <param name="CurrUserID">The curr user identifier.</param>
    ''' <param name="GlobalSearcher">if set to <c>true</c> [global searcher].</param>
    ''' <param name="LibraryName">Name of the library.</param>
    ''' <param name="LocationID">The location identifier.</param>
    ''' <returns>System.String.</returns>
    Public Function genLibrarySearch(ByVal CurrUserID As String, ByVal GlobalSearcher As Boolean, ByVal LibraryName As String, ByVal LocationID As String) As String

        Dim S As String = ""
        'S = S + " SELECT GroupUsers.GroupName, Library.LibraryName, LibraryUsers.UserID, LibraryItems.SourceGuid" + chrw(9) + chrw(9) + " /*KEEP*/" + vbCrLf
        S = S + " /* GENID:" + LocationID + " *KEEP*/" + vbCrLf
        S = S + " SELECT LibraryItems.SourceGuid" + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
        S = S + ChrW(9) + " FROM   LibraryItems INNER JOIN" + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
        S = S + ChrW(9) + "        Library ON LibraryItems.LibraryName = Library.LibraryName INNER JOIN" + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
        S = S + ChrW(9) + "        LibraryUsers ON Library.LibraryName = LibraryUsers.LibraryName INNER JOIN" + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
        S = S + ChrW(9) + "        GroupLibraryAccess ON Library.LibraryName = GroupLibraryAccess.LibraryName INNER JOIN" + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
        S = S + ChrW(9) + "        GroupUsers ON GroupLibraryAccess.GroupName = GroupUsers.GroupName" + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
        S = S + ChrW(9) + " where " + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
        S = S + ChrW(9) + "        Library.LibraryName ='" + LibraryName + "' " + ChrW(9) + ChrW(9) + " /*KEEP*/   /*ID57*/" + vbCrLf

        If GlobalSearcher = False Then
            S = S + ChrW(9) + " AND    libraryusers.userid ='" + CurrUserID + "' " + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
        End If
        S = S + ChrW(9) + "        /* GLOBAL Searcher = " + GlobalSearcher.ToString + "  */" + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf

        S = S + ChrW(9) + "UNION " + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf

        S = S + ChrW(9) + "Select LI.SourceGuid" + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
        S = S + ChrW(9) + "FROM   LibraryItems AS LI INNER JOIN" + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
        S = S + ChrW(9) + "       LibraryUsers AS LU ON LI.LibraryName = LU.LibraryName" + ChrW(9) + ChrW(9) + " /*KEEP*/   /*ID58*/" + vbCrLf
        If GlobalSearcher = False Then
            S = S + ChrW(9) + "WHERE     LI.LibraryName = '" + LibraryName + "'" + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
            S = S + ChrW(9) + "    AND LU.UserID = '" + CurrUserID + "'" + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
        Else
            S = S + ChrW(9) + "WHERE     LI.LibraryName = '" + LibraryName + "'" + ChrW(9) + ChrW(9) + " /*KEEP*/" + vbCrLf
        End If

        Return S

    End Function

End Class
