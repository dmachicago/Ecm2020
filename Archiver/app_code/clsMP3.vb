Imports HundredMilesSoftware.UltraID3Lib
Imports System
Imports System.IO
Imports System.Runtime.InteropServices
Imports System.ComponentModel


Public Class clsMP3
    Inherits clsDatabaseARCH

    Dim UD As New UltraID3
    'Dim DBARCH As New clsDatabaseARCH

    Dim DMA As New clsDma
    Dim LOG As New clsLogging
    Dim UTIL As New clsUtility

    Dim ATTR As New clsATTRIBUTES
    Dim sAttr As New clsSOURCEATTRIBUTE
    Dim DFLT As New clsValidateCodes
    Shadows ddebug As Boolean = True
    Dim KeyWords As New ArrayList


    Sub getKeyWords(ByVal Phrase As String)
        Dim Words As String = ""


        Dim I As Integer = 0
        Dim dels As String = " ,.:;-"
        Dim A As String() = Split(Phrase, " ")
        For I = 1 To dels.Length
            Dim CH As String = Mid(dels, I, 1)
            A = Split(Phrase, CH)
            For k As Integer = 0 To UBound(A)
                Dim bFound As Boolean = False
                For ii As Integer = 0 To UBound(A)
                    Dim tgtWord As String = A(ii).ToString
                    If Not KeyWords.Contains(tgtWord) Then
                        KeyWords.Add(tgtWord)
                    End If
                    'If UCase(A(k)) = UCase(tgtword) Then
                    '    bFound = True
                    '    Exit For
                    'End If
                Next
                'If bFound = False Then
                '    KeyWords.Add(A(k))
                'End If
            Next
        Next
    End Sub
    Sub getRecordingMetaData(ByVal FQN As String, ByVal SourceGuid As String, ByVal FileType As String)
        Try
            KeyWords.Clear()

            If InStr(FQN, "''") > 0 Then
                FQN = UTIL.ReplaceSingleQuotes(FQN)
            End If

            If LCase(FileType).Equals(".mp3") Then
            ElseIf LCase(FileType).Equals(".wma") Then
            Else
                Return
            End If
            'Dim w As New clsWMAID3Tag(FQN)
            'Dim id As New clsID3V1Tag(FQN)

            Dim S As String = ""


            If FQN = "" Then
                LOG.WriteToArchiveLog("ERROR 33.24.1 - getRecordingMetaData - No file name supplied - returning.")
                Return
            End If


            S = FQN
            S = S.Substring(S.LastIndexOf("."c) + 1)
            If S = "wma" Then
                Try
                    Dim w As New clsWMAID3Tag(FQN)

                    Dim tbTitle As String = w.title
                    Dim tbArtist As String = w.artist
                    Dim tbAlbum As String = w.album
                    Dim tbGenre As String = w.genre
                    Dim tbYear As String = w.year.ToString
                    Dim tbTrack As String = w.track.ToString
                    Dim tbDescription As String = w.description

                    Dim bUpdateContent As Boolean = False

                    If tbTitle = Nothing Then
                    ElseIf tbTitle.Trim.Length > 0 Then
                        AddMetaData("Song Title", tbTitle, SourceGuid, "S", "WMA")
                        getKeyWords(tbTitle)
                        bUpdateContent = True
                    End If


                    If tbArtist = Nothing Then
                    ElseIf tbArtist.Trim.Length > 0 Then
                        AddMetaData("Song Artist", tbArtist, SourceGuid, "S", "WMA")
                        getKeyWords(tbArtist)
                        bUpdateContent = True
                    End If


                    If tbAlbum = Nothing Then
                    ElseIf tbAlbum.Trim.Length > 0 Then
                        AddMetaData("Album", tbAlbum, SourceGuid, "S", "WMA")
                        getKeyWords(tbAlbum)
                        bUpdateContent = True
                    End If


                    If tbGenre = Nothing Then
                    ElseIf tbGenre.Trim.Length > 0 Then
                        AddMetaData("Genre", tbGenre, SourceGuid, "S", "WMA")
                        getKeyWords(tbGenre)
                        bUpdateContent = True
                    End If


                    If tbYear = Nothing Then
                    ElseIf tbYear.Trim.Length > 0 Then
                        AddMetaData("Year", tbGenre, SourceGuid, "I", "WMA")
                        getKeyWords(tbYear)
                        'bUpdateContent = True
                    End If
                    If tbTrack.Trim.Length > 0 Then
                        AddMetaData("Track", tbTrack, SourceGuid, "I", "WMA")
                        getKeyWords(tbTrack)
                        bUpdateContent = True
                    End If

                    If KeyWords.Count > 0 Then
                        AddMetaData("music", "Y", SourceGuid, "S", "WMA")
                        tbDescription = "Music WMA "
                        tbDescription += RemoveDuplicateKeyWords(KeyWords)
                    End If

                    If tbDescription Is Nothing Then
                    Else
                        If tbDescription.Trim.Length > 0 Then
                            tbDescription = UTIL.RemoveSingleQuotes(tbDescription)
                            S = "Update DataSource set Description = '" + tbDescription + "' Where SourceGuid = '" + SourceGuid + "'"
                            Dim BB As Boolean = ExecuteSqlNewConn(S, False)
                            If Not BB Then
                                LOG.WriteToArchiveLog("Warning - 100.22 getRecordingMetaData: Failed to add description to recording:" + tbTitle + " : " + FQN)
                            End If
                        End If
                    End If


                    'If tbDescription Is Nothing Then
                    'Else
                    '    If tbDescription.Trim.Length > 0 Then
                    '        tbDescription = UTIL.RemoveSingleQuotes(tbDescription)
                    '        S = "Update DataSource set Description = '" + tbDescription + " Where SourceGuid '" + SourceGuid + "'"
                    '        ExecuteSqlNewConn(S, False)
                    '    End If
                    'End If


                    If bUpdateContent = True Then
                        Dim KW = ""

                        For i As Integer = 0 To KeyWords.Count - 1
                            KW += KeyWords(i).ToString + " "
                        Next
                        KW = KW.Trim
                        If KW.Length > 0 Then
                            KW = UTIL.RemoveSingleQuotes(KW)
                            S = "Update DataSource set KeyWords = '" + KW + "' Where SourceGuid = '" + SourceGuid + "'"
                            ExecuteSqlNewConn(S, False)
                        End If


                    End If


                Catch ex As Exception
                    Debug.Print(FQN & " is not a valid wma file or has invalid tag information")
                    LOG.WriteToArchiveLog("clsMP3 : getRecordingMetaData : 106 : " + ex.Message)
                    Return
                End Try




            ElseIf S = "mp3" Then
                Try
                    Dim id As New clsID3V1Tag(FQN)


                    Dim tbTitle As String = id.title
                    Dim tbArtist As String = id.artist
                    Dim tbAlbum As String = id.album
                    Dim tbGenre As String = id.genre
                    Dim tbYear As String = id.year.ToString
                    Dim tbTrack As String = id.track.ToString
                    Dim tbDescription As String = id.comment


                    Dim bUpdateContent As Boolean = False


                    If tbTitle = Nothing Then
                    ElseIf tbTitle.Trim.Length > 0 Then
                        AddMetaData("Song Title", tbTitle, SourceGuid, "S", "MP3")
                        getKeyWords(tbTitle)
                        bUpdateContent = True
                    End If


                    If tbArtist = Nothing Then
                    ElseIf tbArtist.Trim.Length > 0 Then
                        AddMetaData("Song Artist", tbArtist, SourceGuid, "S", "MP3")
                        getKeyWords(tbArtist)
                        bUpdateContent = True
                    End If


                    If tbAlbum = Nothing Then
                    ElseIf tbAlbum.Trim.Length > 0 Then
                        AddMetaData("Album", tbAlbum, SourceGuid, "S", "MP3")
                        getKeyWords(tbAlbum)
                        bUpdateContent = True
                    End If


                    If tbGenre = Nothing Then
                    ElseIf tbGenre.Trim.Length > 0 Then
                        AddMetaData("Genre", tbGenre, SourceGuid, "S", "MP3")
                        getKeyWords(tbGenre)
                        bUpdateContent = True
                    End If


                    If tbYear = Nothing Then
                    ElseIf tbYear.Trim.Length > 0 Then
                        AddMetaData("Year", tbYear, SourceGuid, "I", "MP3")
                        getKeyWords(tbYear)
                        bUpdateContent = True
                    End If
                    If tbTrack.Trim.Length > 0 Then
                        AddMetaData("Track", tbTrack, SourceGuid, "I", "MP3")
                        getKeyWords(tbTrack)
                        bUpdateContent = True
                    End If

                    If KeyWords.Count > 0 Then
                        AddMetaData("music", "Y", SourceGuid, "S", "MP3")
                        tbDescription = "Music MP3 "
                        tbDescription += RemoveDuplicateKeyWords(KeyWords)
                    End If

                    If tbDescription Is Nothing Then
                    Else
                        If tbDescription.Trim.Length > 0 Then
                            tbDescription = UTIL.RemoveSingleQuotes(tbDescription)
                            S = "Update DataSource set Description = '" + tbDescription + "' Where SourceGuid = '" + SourceGuid + "'"
                            Dim Bb As Boolean = ExecuteSqlNewConn(S, False)
                            If Not Bb Then
                                LOG.WriteToArchiveLog("Warning - 100.22 getRecordingMetaData: Failed to add description to recording: " + tbTitle + " : " + FQN)
                            End If
                        End If
                    End If


                    If bUpdateContent = True Then
                        Dim KW = RemoveDuplicateKeyWords(KeyWords)
                        KW = KW.Trim
                        If KW.Length > 0 Then
                            S = "Update DataSource set KeyWords = '" + KW + "' Where SourceGuid = '" + SourceGuid + "'"
                            ExecuteSqlNewConn(S, False)
                        End If
                    End If


                Catch ex As Exception
                    Debug.Print(FQN & " is not a valid mp3 file or has invalid tag information")
                    LOG.WriteToArchiveLog("clsMP3 : getRecordingMetaData : 172 : " + ex.Message)
                    Return
                End Try


            End If
        Catch ex As Exception
            xTrace(3654, "getRecordingMetaData", ex.Message.ToString)
            LOG.WriteToArchiveLog("clsMP3 : getRecordingMetaData : 174 : " + ex.Message)
        End Try


    End Sub
    Function RemoveDuplicateKeyWords(ByVal KeyWords As ArrayList) As String
        Dim NewWords As New ArrayList
        Dim A(0) As String
        Dim S As String = ""
        Dim aBet As String = "abcdefghijklmnopqrstuvwxyz1234567890&"

        For I As Integer = 0 To KeyWords.Count - 1
            Dim tString As String = KeyWords.Item(I)

            For ii As Integer = 1 To tString.Length
                Dim CH As String = Mid(tString, ii, 1)
                If InStr(aBet, CH, CompareMethod.Text) = 0 Then
                    Mid(tString, ii, 1) = " "
                End If
            Next

            tString = tString.Trim
            If InStr(tString, " ") > 0 Then
                A = tString.Split(" ")
                For ii As Integer = 0 To A.Length - 1
                    Dim tWord As String = A(ii)
                    If Not NewWords.Contains(tWord) And tWord.Length > 0 Then
                        NewWords.Add(tWord)
                    End If
                Next
            Else
                If Not NewWords.Contains(tString) And tString.Length > 0 Then
                    NewWords.Add(tString)
                End If
            End If

        Next

        For i As Integer = 0 To NewWords.Count - 1
            S = S + NewWords(i) + " "
        Next
        Return S
    End Function

    Private Function getMetaData(ByVal FQN As String, ByVal SourceGuid As String) As SortedList(Of String, String)

        Dim L As New SortedList(Of String, String)

        Try
            Dim B As Boolean = False


            'Read the track file
            UD.Read(FQN)

            B = UD.ID3v2Tag.ExistsInFile

            'Display a single string representation of the common ID3 fields
            Dim SongInfo As String = UD.ToString
            'Dim A () = Split(SongInfo, vbCr)

            'For i As Integer = 0 To UBound(A)
            '    Dim A2 () = Split(A(i), ":")
            '    Dim J As Integer = UBound(A2)
            '    If J >= 1 Then
            '        Debug.Print(A2(0))
            '        Debug.Print(A2(1))
            '        Debug.Print("______")
            '    End If
            'Next


            'Display the Title, letting UltraID3 determine the appropriate tag source
            Dim SongTitle As String = UD.Title
            Dim Album As String = UD.Album
            Dim Artist As String = UD.Artist
            'Dim Duration As TimeSpan = UD.Duration.ToString
            Dim Duration As String = UD.Duration.ToString
            Dim FileName As String = UD.FileName
            Dim Genre As String = UD.Genre.ToString

            L.Add("SongTitle", SongTitle)
            L.Add("Album", Album)
            L.Add("Artist", Artist)
            L.Add("Duration", Duration)
            L.Add("FileName", FileName)
            L.Add("Genre", Genre)

            Return L



            'B = UD.ID3v2Tag.ExistsInFile
            'If B Then
            '    Debug.Print(UD.ID3v2Tag.ToString)
            '    Dim ID3v2GenreName = UD.ID3v1Tag.GenreName
            '    Dim ID3v2Genre = UD.ID3v1Tag.Genre
            '    Dim ID3v2GenreLyrics3v2WasFound As Boolean = UD.ID3v1Tag.Lyrics3v2WasFound
            '    Dim ID3v2Title = UD.ID3v1Tag.Title
            '    Dim ID3v2TrackNum = UD.ID3v1Tag.TrackNum
            '    Dim ID3v2Year = UD.ID3v1Tag.Year
            '    Dim Comments  = UD.ID3v1Tag.Comments
            'End If


            'If UD.ID3v1Tag.ExistsInFile Then
            '    'Display the Title property of the ID3v1Tag directly
            '    Debug.Print(UD.ID3v1Tag.ToString)
            '    Dim ID3v1GenreName = UD.ID3v1Tag.GenreName
            '    Dim ID3v1Genre = UD.ID3v1Tag.Genre
            '    Dim ID3v1GenreLyrics3v2WasFound As Boolean = UD.ID3v1Tag.Lyrics3v2WasFound
            '    Dim ID3v1Title = UD.ID3v1Tag.Title
            '    Dim ID3v1TrackNum = UD.ID3v1Tag.TrackNum
            '    Dim ID3v1Year = UD.ID3v1Tag.Year
            '    Dim Comments  = UD.ID3v1Tag.Comments


            'End If


            ''Retrieve any non-fatal exceptions which might have occurred
            'Dim E() = UD.GetExceptions()


            'If E.Length > 0 Then
            '    'Dim IndexUltraID3TagException As UltraID3TagException
            '    'Iterate through each found non-fatal exception
            '    For Each S As String In E
            '        'Display the Message of the non-fatal exception
            '        Debug.Print(E.ToString)
            '    Next


            'End If


            'Catch any fatal exceptions
        Catch exc As Exception
            LOG.WriteToArchiveLog("ERROR in processing MP3 Metadata: " + exc.Message)
            LOG.WriteToArchiveLog("clsMP3 : getMetaData : 224 Filename: " + FQN)
        End Try

        Return L

    End Function
    Sub AddMetaData(ByVal tkey As String, ByVal tVal As String, ByVal DocGuid As String, ByVal DataType As String, ByVal FileType As String)

        If tVal.Length = 0 Then
            Return
        End If

        Try
            If ddebug Then Debug.Print(tkey + ":" + tVal)
            If tkey.Length > 0 And tVal.Length > 0 Then
                sAttr.setAttributename(tkey)
                sAttr.setAttributevalue(tVal)
                sAttr.setSourceguid(DocGuid)
                sAttr.setDatasourceowneruserid(gCurrUserGuidID)
                sAttr.setSourcetypecode(FileType)
                Dim bb As Boolean = ItemExists("Attributes", "AttributeName", tkey, "C")
                If bb = False Then
                    DFLT.addDefaultAttributes(tkey, DataType, "Auto added: initWordDocMetaData", FileType)
                End If
                bb = sAttr.Insert()
                If Not bb Then
                    Debug.Print("ERROR XX23.01: failed to add metadata.")
                End If
            End If
        Catch ex As Exception
            If ddebug Then Debug.Print(ex.Message)
            xTrace(23946, "AddMetaData", "Failed to add Metedata for: " + getFilenameByGuid(DocGuid) + " : " + ex.Message.ToString)
            LOG.WriteToArchiveLog("clsMP3 : AddMetaData : 242 : " + ex.Message)
        End Try
    End Sub
End Class


