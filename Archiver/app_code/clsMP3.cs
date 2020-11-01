using global::System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using global::HundredMilesSoftware.UltraID3Lib;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public class clsMP3 : clsDatabaseARCH
    {
        private UltraID3 UD = new UltraID3();
        // Dim DBARCH As New clsDatabaseARCH

        private clsDma DMA = new clsDma();
        private clsLogging LOG = new clsLogging();
        private clsUtility UTIL = new clsUtility();
        private clsATTRIBUTES ATTR = new clsATTRIBUTES();
        private clsSOURCEATTRIBUTE sAttr = new clsSOURCEATTRIBUTE();
        private clsValidateCodes DFLT = new clsValidateCodes();
        private new bool ddebug = true;
        private ArrayList KeyWords = new ArrayList();

        public void getKeyWords(string Phrase)
        {
            string Words = "";
            int I = 0;
            string dels = " ,.:;-";
            var A = Strings.Split(Phrase, " ");
            var loopTo = dels.Length;
            for (I = 1; I <= loopTo; I++)
            {
                string CH = Strings.Mid(dels, I, 1);
                A = Strings.Split(Phrase, CH);
                for (int k = 0, loopTo1 = Information.UBound(A); k <= loopTo1; k++)
                {
                    bool bFound = false;
                    for (int ii = 0, loopTo2 = Information.UBound(A); ii <= loopTo2; ii++)
                    {
                        string tgtWord = A[ii].ToString();
                        if (!KeyWords.Contains(tgtWord))
                        {
                            KeyWords.Add(tgtWord);
                        }
                        // If UCase(A(k)) = UCase(tgtword) Then
                        // bFound = True
                        // Exit For
                        // End If
                    }
                    // If bFound = False Then
                    // KeyWords.Add(A(k))
                    // End If
                }
            }
        }

        public void getRecordingMetaData(string FQN, string SourceGuid, string FileType)
        {
            try
            {
                KeyWords.Clear();
                if (Strings.InStr(FQN, "''") > 0)
                {
                    FQN = UTIL.ReplaceSingleQuotes(FQN);
                }

                if (Strings.LCase(FileType).Equals(".mp3"))
                {
                }
                else if (Strings.LCase(FileType).Equals(".wma"))
                {
                }
                else
                {
                    return;
                }
                // Dim w As New clsWMAID3Tag(FQN)
                // Dim id As New clsID3V1Tag(FQN)

                string S = "";
                if (string.IsNullOrEmpty(FQN))
                {
                    LOG.WriteToArchiveLog("ERROR 33.24.1 - getRecordingMetaData - No file name supplied - returning.");
                    return;
                }

                S = FQN;
                S = S.Substring(S.LastIndexOf('.') + 1);
                if (S == "wma")
                {
                    try
                    {
                        var w = new clsWMAID3Tag(FQN);
                        string tbTitle = w.title;
                        string tbArtist = w.artist;
                        string tbAlbum = w.album;
                        string tbGenre = w.genre;
                        string tbYear = w.year.ToString();
                        string tbTrack = w.track.ToString();
                        string tbDescription = w.description;
                        bool bUpdateContent = false;
                        if (tbTitle == null)
                        {
                        }
                        else if (tbTitle.Trim().Length > 0)
                        {
                            AddMetaData("Song Title", tbTitle, SourceGuid, "S", "WMA");
                            getKeyWords(tbTitle);
                            bUpdateContent = true;
                        }

                        if (tbArtist == null)
                        {
                        }
                        else if (tbArtist.Trim().Length > 0)
                        {
                            AddMetaData("Song Artist", tbArtist, SourceGuid, "S", "WMA");
                            getKeyWords(tbArtist);
                            bUpdateContent = true;
                        }

                        if (tbAlbum == null)
                        {
                        }
                        else if (tbAlbum.Trim().Length > 0)
                        {
                            AddMetaData("Album", tbAlbum, SourceGuid, "S", "WMA");
                            getKeyWords(tbAlbum);
                            bUpdateContent = true;
                        }

                        if (tbGenre == null)
                        {
                        }
                        else if (tbGenre.Trim().Length > 0)
                        {
                            AddMetaData("Genre", tbGenre, SourceGuid, "S", "WMA");
                            getKeyWords(tbGenre);
                            bUpdateContent = true;
                        }

                        if (tbYear == null)
                        {
                        }
                        else if (tbYear.Trim().Length > 0)
                        {
                            AddMetaData("Year", tbGenre, SourceGuid, "I", "WMA");
                            getKeyWords(tbYear);
                            // bUpdateContent = True
                        }

                        if (tbTrack.Trim().Length > 0)
                        {
                            AddMetaData("Track", tbTrack, SourceGuid, "I", "WMA");
                            getKeyWords(tbTrack);
                            bUpdateContent = true;
                        }

                        if (KeyWords.Count > 0)
                        {
                            AddMetaData("music", "Y", SourceGuid, "S", "WMA");
                            tbDescription = "Music WMA ";
                            tbDescription += RemoveDuplicateKeyWords(KeyWords);
                        }

                        if (tbDescription is null)
                        {
                        }
                        else if (tbDescription.Trim().Length > 0)
                        {
                            tbDescription = UTIL.RemoveSingleQuotes(tbDescription);
                            S = "Update DataSource set Description = '" + tbDescription + "' Where SourceGuid = '" + SourceGuid + "'";
                            bool BB = ExecuteSqlNewConn(S, false);
                            if (!BB)
                            {
                                LOG.WriteToArchiveLog("Warning - 100.22 getRecordingMetaData: Failed to add description to recording:" + tbTitle + " : " + FQN);
                            }
                        }


                        // If tbDescription Is Nothing Then
                        // Else
                        // If tbDescription.Trim.Length > 0 Then
                        // tbDescription = UTIL.RemoveSingleQuotes(tbDescription)
                        // S = "Update DataSource set Description = '" + tbDescription + " Where SourceGuid '" + SourceGuid + "'"
                        // ExecuteSqlNewConn(S, False)
                        // End If
                        // End If


                        if (bUpdateContent == true)
                        {
                            string KW = "";
                            for (int i = 0, loopTo = KeyWords.Count - 1; i <= loopTo; i++)
                                KW += KeyWords[i].ToString() + " ";
                            KW = KW.Trim();
                            if (KW.Length > 0)
                            {
                                KW = UTIL.RemoveSingleQuotes(KW);
                                S = "Update DataSource set KeyWords = '" + KW + "' Where SourceGuid = '" + SourceGuid + "'";
                                ExecuteSqlNewConn(S, false);
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        Debug.Print(FQN + " is not a valid wma file or has invalid tag information");
                        LOG.WriteToArchiveLog("clsMP3 : getRecordingMetaData : 106 : " + ex.Message);
                        return;
                    }
                }
                else if (S == "mp3")
                {
                    try
                    {
                        var id = new clsID3V1Tag(FQN);
                        string tbTitle = id.title;
                        string tbArtist = id.artist;
                        string tbAlbum = id.album;
                        string tbGenre = id.genre;
                        string tbYear = id.year.ToString();
                        string tbTrack = id.track.ToString();
                        string tbDescription = id.comment;
                        bool bUpdateContent = false;
                        if (tbTitle == null)
                        {
                        }
                        else if (tbTitle.Trim().Length > 0)
                        {
                            AddMetaData("Song Title", tbTitle, SourceGuid, "S", "MP3");
                            getKeyWords(tbTitle);
                            bUpdateContent = true;
                        }

                        if (tbArtist == null)
                        {
                        }
                        else if (tbArtist.Trim().Length > 0)
                        {
                            AddMetaData("Song Artist", tbArtist, SourceGuid, "S", "MP3");
                            getKeyWords(tbArtist);
                            bUpdateContent = true;
                        }

                        if (tbAlbum == null)
                        {
                        }
                        else if (tbAlbum.Trim().Length > 0)
                        {
                            AddMetaData("Album", tbAlbum, SourceGuid, "S", "MP3");
                            getKeyWords(tbAlbum);
                            bUpdateContent = true;
                        }

                        if (tbGenre == null)
                        {
                        }
                        else if (tbGenre.Trim().Length > 0)
                        {
                            AddMetaData("Genre", tbGenre, SourceGuid, "S", "MP3");
                            getKeyWords(tbGenre);
                            bUpdateContent = true;
                        }

                        if (tbYear == null)
                        {
                        }
                        else if (tbYear.Trim().Length > 0)
                        {
                            AddMetaData("Year", tbYear, SourceGuid, "I", "MP3");
                            getKeyWords(tbYear);
                            bUpdateContent = true;
                        }

                        if (tbTrack.Trim().Length > 0)
                        {
                            AddMetaData("Track", tbTrack, SourceGuid, "I", "MP3");
                            getKeyWords(tbTrack);
                            bUpdateContent = true;
                        }

                        if (KeyWords.Count > 0)
                        {
                            AddMetaData("music", "Y", SourceGuid, "S", "MP3");
                            tbDescription = "Music MP3 ";
                            tbDescription += RemoveDuplicateKeyWords(KeyWords);
                        }

                        if (tbDescription is null)
                        {
                        }
                        else if (tbDescription.Trim().Length > 0)
                        {
                            tbDescription = UTIL.RemoveSingleQuotes(tbDescription);
                            S = "Update DataSource set Description = '" + tbDescription + "' Where SourceGuid = '" + SourceGuid + "'";
                            bool Bb = ExecuteSqlNewConn(S, false);
                            if (!Bb)
                            {
                                LOG.WriteToArchiveLog("Warning - 100.22 getRecordingMetaData: Failed to add description to recording: " + tbTitle + " : " + FQN);
                            }
                        }

                        if (bUpdateContent == true)
                        {
                            string KW = RemoveDuplicateKeyWords(KeyWords);
                            KW = KW.Trim();
                            if (KW.Length > 0)
                            {
                                S = "Update DataSource set KeyWords = '" + KW + "' Where SourceGuid = '" + SourceGuid + "'";
                                ExecuteSqlNewConn(S, false);
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        Debug.Print(FQN + " is not a valid mp3 file or has invalid tag information");
                        LOG.WriteToArchiveLog("clsMP3 : getRecordingMetaData : 172 : " + ex.Message);
                        return;
                    }
                }
            }
            catch (Exception ex)
            {
                xTrace(3654, "getRecordingMetaData", ex.Message.ToString());
                LOG.WriteToArchiveLog("clsMP3 : getRecordingMetaData : 174 : " + ex.Message);
            }
        }

        public string RemoveDuplicateKeyWords(ArrayList KeyWords)
        {
            var NewWords = new ArrayList();
            var A = new string[1];
            string S = "";
            string aBet = "abcdefghijklmnopqrstuvwxyz1234567890&";
            for (int I = 0, loopTo = KeyWords.Count - 1; I <= loopTo; I++)
            {
                string tString = Conversions.ToString(KeyWords[I]);
                for (int ii = 1, loopTo1 = tString.Length; ii <= loopTo1; ii++)
                {
                    string CH = Strings.Mid(tString, ii, 1);
                    if (Strings.InStr(aBet, CH, CompareMethod.Text) == 0)
                    {
                        StringType.MidStmtStr(ref tString, ii, 1, " ");
                    }
                }

                tString = tString.Trim();
                if (Strings.InStr(tString, " ") > 0)
                {
                    A = tString.Split(' ');
                    for (int ii = 0, loopTo2 = A.Length - 1; ii <= loopTo2; ii++)
                    {
                        string tWord = A[ii];
                        if (!NewWords.Contains(tWord) & tWord.Length > 0)
                        {
                            NewWords.Add(tWord);
                        }
                    }
                }
                else if (!NewWords.Contains(tString) & tString.Length > 0)
                {
                    NewWords.Add(tString);
                }
            }

            for (int i = 0, loopTo3 = NewWords.Count - 1; i <= loopTo3; i++)
                S = Conversions.ToString(Operators.AddObject(Operators.AddObject(S, NewWords[i]), " "));
            return S;
        }

        private SortedList<string, string> getMetaData(string FQN, string SourceGuid)
        {
            var L = new SortedList<string, string>();
            try
            {
                bool B = false;


                // Read the track file
                UD.Read(FQN);
                B = UD.ID3v2Tag.ExistsInFile;

                // Display a single string representation of the common ID3 fields
                string SongInfo = UD.ToString();
                // Dim A () = Split(SongInfo, vbCr)

                // For i As Integer = 0 To UBound(A)
                // Dim A2 () = Split(A(i), ":")
                // Dim J As Integer = UBound(A2)
                // If J >= 1 Then
                // Debug.Print(A2(0))
                // Debug.Print(A2(1))
                // Debug.Print("______")
                // End If
                // Next


                // Display the Title, letting UltraID3 determine the appropriate tag source
                string SongTitle = UD.Title;
                string Album = UD.Album;
                string Artist = UD.Artist;
                // Dim Duration As TimeSpan = UD.Duration.ToString
                string Duration = UD.Duration.ToString();
                string FileName = UD.FileName;
                string Genre = UD.Genre.ToString();
                L.Add("SongTitle", SongTitle);
                L.Add("Album", Album);
                L.Add("Artist", Artist);
                L.Add("Duration", Duration);
                L.Add("FileName", FileName);
                L.Add("Genre", Genre);
                return L;
            }



            // B = UD.ID3v2Tag.ExistsInFile
            // If B Then
            // Debug.Print(UD.ID3v2Tag.ToString)
            // Dim ID3v2GenreName = UD.ID3v1Tag.GenreName
            // Dim ID3v2Genre = UD.ID3v1Tag.Genre
            // Dim ID3v2GenreLyrics3v2WasFound As Boolean = UD.ID3v1Tag.Lyrics3v2WasFound
            // Dim ID3v2Title = UD.ID3v1Tag.Title
            // Dim ID3v2TrackNum = UD.ID3v1Tag.TrackNum
            // Dim ID3v2Year = UD.ID3v1Tag.Year
            // Dim Comments  = UD.ID3v1Tag.Comments
            // End If


            // If UD.ID3v1Tag.ExistsInFile Then
            // 'Display the Title property of the ID3v1Tag directly
            // Debug.Print(UD.ID3v1Tag.ToString)
            // Dim ID3v1GenreName = UD.ID3v1Tag.GenreName
            // Dim ID3v1Genre = UD.ID3v1Tag.Genre
            // Dim ID3v1GenreLyrics3v2WasFound As Boolean = UD.ID3v1Tag.Lyrics3v2WasFound
            // Dim ID3v1Title = UD.ID3v1Tag.Title
            // Dim ID3v1TrackNum = UD.ID3v1Tag.TrackNum
            // Dim ID3v1Year = UD.ID3v1Tag.Year
            // Dim Comments  = UD.ID3v1Tag.Comments


            // End If


            // 'Retrieve any non-fatal exceptions which might have occurred
            // Dim E() = UD.GetExceptions()


            // If E.Length > 0 Then
            // 'Dim IndexUltraID3TagException As UltraID3TagException
            // 'Iterate through each found non-fatal exception
            // For Each S As String In E
            // 'Display the Message of the non-fatal exception
            // Debug.Print(E.ToString)
            // Next


            // End If


            // Catch any fatal exceptions
            catch (Exception exc)
            {
                LOG.WriteToArchiveLog("ERROR in processing MP3 Metadata: " + exc.Message);
                LOG.WriteToArchiveLog("clsMP3 : getMetaData : 224 Filename: " + FQN);
            }

            return L;
        }

        public void AddMetaData(string tkey, string tVal, string DocGuid, string DataType, string FileType)
        {
            if (tVal.Length == 0)
            {
                return;
            }

            try
            {
                if (ddebug)
                    Debug.Print(tkey + ":" + tVal);
                if (tkey.Length > 0 & tVal.Length > 0)
                {
                    sAttr.setAttributename(ref tkey);
                    sAttr.setAttributevalue(ref tVal);
                    sAttr.setSourceguid(ref DocGuid);
                    sAttr.setDatasourceowneruserid(ref modGlobals.gCurrUserGuidID);
                    sAttr.setSourcetypecode(ref FileType);
                    bool bb = ItemExists("Attributes", "AttributeName", tkey, "C");
                    if (bb == false)
                    {
                        DFLT.addDefaultAttributes(tkey, DataType, "Auto added: initWordDocMetaData", FileType);
                    }

                    bb = sAttr.Insert();
                    if (!bb)
                    {
                        Debug.Print("ERROR XX23.01: failed to add metadata.");
                    }
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Debug.Print(ex.Message);
                xTrace(23946, "AddMetaData", "Failed to add Metedata for: " + getFilenameByGuid(DocGuid) + " : " + ex.Message.ToString());
                LOG.WriteToArchiveLog("clsMP3 : AddMetaData : 242 : " + ex.Message);
            }
        }
    }
}