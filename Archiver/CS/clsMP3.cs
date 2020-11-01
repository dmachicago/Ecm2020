// VBConversions Note: VB project level imports
using System.Collections.Generic;
using System;
using System.Drawing;
using System.Linq;
using System.Diagnostics;
using System.Data;
using Microsoft.VisualBasic;
using MODI;
using System.Xml.Linq;
using System.Collections;
using System.Windows.Forms;
// End of VB project level imports

using HundredMilesSoftware.UltraID3Lib;
using System.IO;
using System.Runtime.InteropServices;
using System.ComponentModel;
using Microsoft.VisualBasic.CompilerServices;



namespace EcmArchiveClcSetup
{
	public class clsMP3
	{
		
		
		UltraID3 UD = new UltraID3();
		clsDatabase DB = new clsDatabase();
		
		clsDma DMA = new clsDma();
		clsLogging LOG = new clsLogging();
		clsUtility UTIL = new clsUtility();
		
		clsATTRIBUTES ATTR = new clsATTRIBUTES();
		clsSOURCEATTRIBUTE sAttr = new clsSOURCEATTRIBUTE();
		clsValidateCodes DFLT = new clsValidateCodes();
		bool ddebug = true;
		ArrayList KeyWords = new ArrayList();
		
		
		public void getKeyWords(string Phrase)
		{
			string Words = "";
			
			
			int I = 0;
			string dels = " ,.:;-";
			string[] A = Phrase.Split(' ');
			for (I = 1; I <= dels.Length; I++)
			{
				string CH = dels.Substring(I - 1, 1);
				A = Phrase.Split(CH.ToCharArray()[0]);
				for (int k = 0; k <= (A.Length - 1); k++)
				{
					bool bFound = false;
					for (int ii = 0; ii <= (A.Length - 1); ii++)
					{
						string tgtWord = A[ii].ToString();
						if (! KeyWords.Contains(tgtWord))
						{
							KeyWords.Add(tgtWord);
						}
						//If UCase(A(k)) = UCase(tgtword) Then
						//    bFound = True
						//    Exit For
						//End If
					}
					//If bFound = False Then
					//    KeyWords.Add(A(k))
					//End If
				}
			}
		}
		public void getRecordingMetaData(string FQN, string SourceGuid, string FileType)
		{
			try
			{
				KeyWords.Clear();
				
				if (FQN.IndexOf("\'\'") + 1 > 0)
				{
					FQN = UTIL.ReplaceSingleQuotes(FQN);
				}
				
				if (FileType.ToLower().Equals(".mp3"))
				{
				}
				else if (FileType.ToLower().Equals(".wma"))
				{
				}
				else
				{
					return;
				}
				//Dim w As New clsWMAID3Tag(FQN)
				//Dim id As New clsID3V1Tag(FQN)
				
				string S = "";
				
				
				if (FQN == "")
				{
					LOG.WriteToArchiveLog("ERROR 33.24.1 - getRecordingMetaData - No file name supplied - returning.");
					return;
				}
				
				
				S = FQN;
				S = S.Substring(System.Convert.ToInt32(S.LastIndexOf('.') + 1));
				if (S == "wma")
				{
					try
					{
						clsWMAID3Tag w = new clsWMAID3Tag(FQN);
						
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
							//bUpdateContent = True
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
						
						if (tbDescription == null)
						{
						}
						else
						{
							if (tbDescription.Trim().Length > 0)
							{
								tbDescription = UTIL.RemoveSingleQuotes(tbDescription);
								S = "Update DataSource set Description = \'" + tbDescription + "\' Where SourceGuid = \'" + SourceGuid + "\'";
								bool BB = DB.ExecuteSqlNewConn(S, false);
								if (! BB)
								{
									LOG.WriteToArchiveLog((string) ("Warning - 100.22 getRecordingMetaData: Failed to add description to recording:" + tbTitle + " : " + FQN));
								}
							}
						}
						
						
						//If tbDescription Is Nothing Then
						//Else
						//    If tbDescription.Trim.Length > 0 Then
						//        tbDescription = UTIL.RemoveSingleQuotes(tbDescription)
						//        S = "Update DataSource set Description = '" + tbDescription + " Where SourceGuid '" + SourceGuid + "'"
						//        DB.ExecuteSqlNewConn(S, False)
						//    End If
						//End If
						
						
						if (bUpdateContent == true)
						{
							var KW = "";
							
							for (int i = 0; i <= KeyWords.Count - 1; i++)
							{
								KW += (string) (KeyWords[i].ToString() + " ");
							}
							KW = KW.Trim();
							if (KW.Length > 0)
							{
								KW = UTIL.RemoveSingleQuotes(KW);
								S = "Update DataSource set KeyWords = \'" + KW + "\' Where SourceGuid = \'" + SourceGuid + "\'";
								DB.ExecuteSqlNewConn(S, false);
							}
							
							
						}
						
						
					}
					catch (Exception ex)
					{
						Debug.Print(FQN + " is not a valid wma file or has invalid tag information");
						LOG.WriteToArchiveLog((string) ("clsMP3 : getRecordingMetaData : 106 : " + ex.Message));
						return;
					}
					
					
					
					
				}
				else if (S == "mp3")
				{
					try
					{
						clsID3V1Tag id = new clsID3V1Tag(FQN);
						
						
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
						
						if (tbDescription == null)
						{
						}
						else
						{
							if (tbDescription.Trim().Length > 0)
							{
								tbDescription = UTIL.RemoveSingleQuotes(tbDescription);
								S = "Update DataSource set Description = \'" + tbDescription + "\' Where SourceGuid = \'" + SourceGuid + "\'";
								bool Bb = DB.ExecuteSqlNewConn(S, false);
								if (! Bb)
								{
									LOG.WriteToArchiveLog((string) ("Warning - 100.22 getRecordingMetaData: Failed to add description to recording: " + tbTitle + " : " + FQN));
								}
							}
						}
						
						
						if (bUpdateContent == true)
						{
							var KW = RemoveDuplicateKeyWords(KeyWords);
							KW = KW.Trim();
							if (KW.Length > 0)
							{
								S = "Update DataSource set KeyWords = \'" + KW + "\' Where SourceGuid = \'" + SourceGuid + "\'";
								DB.ExecuteSqlNewConn(S, false);
							}
						}
						
						
					}
					catch (Exception ex)
					{
						Debug.Print(FQN + " is not a valid mp3 file or has invalid tag information");
						LOG.WriteToArchiveLog((string) ("clsMP3 : getRecordingMetaData : 172 : " + ex.Message));
						return;
					}
					
					
				}
			}
			catch (Exception ex)
			{
				DB.xTrace(3654, "Failed to process Recording", "getRecordingMetaData", ex);
				LOG.WriteToArchiveLog((string) ("clsMP3 : getRecordingMetaData : 174 : " + ex.Message));
			}
			
			
		}
		public string RemoveDuplicateKeyWords(ArrayList KeyWords)
		{
			ArrayList NewWords = new ArrayList();
			string[] A = new string[1];
			string S = "";
			string aBet = "abcdefghijklmnopqrstuvwxyz1234567890&";
			
			for (int I = 0; I <= KeyWords.Count - 1; I++)
			{
				string tString = (string) (KeyWords[I]);
				
				for (int ii = 1; ii <= tString.Length; ii++)
				{
					string CH = tString.Substring(ii - 1, 1);
					if (aBet.IndexOf(CH) + 1 == 0)
					{
						StringType.MidStmtStr(ref tString, ii, 1, " ");
					}
				}
				
				tString = tString.Trim();
				if (tString.IndexOf(" ") + 1 > 0)
				{
					A = tString.Split(" ".ToCharArray());
					for (int ii = 0; ii <= A.Length - 1; ii++)
					{
						string tWord = A[ii];
						if (! NewWords.Contains(tWord) && tWord.Length > 0)
						{
							NewWords.Add(tWord);
						}
					}
				}
				else
				{
					if (! NewWords.Contains(tString) && tString.Length > 0)
					{
						NewWords.Add(tString);
					}
				}
				
			}
			
			for (int i = 0; i <= NewWords.Count - 1; i++)
			{
				S = S + NewWords[i] + " ";
			}
			return S;
		}
		public SortedList<string, string> getMetaData(string FQN, string SourceGuid)
		{
			
			SortedList<string, string> L = new SortedList<string, string>();
			
			try
			{
				bool B = false;
				
				
				//Read the track file
				UD.Read(FQN);
				
				B = UD.ID3v2Tag.ExistsInFile;
				
				//Display a single string representation of the common ID3 fields
				string SongInfo = UD.ToString();
				//Dim A () = Split(SongInfo, vbCr)
				
				//For i As Integer = 0 To UBound(A)
				//    Dim A2 () = Split(A(i), ":")
				//    Dim J As Integer = UBound(A2)
				//    If J >= 1 Then
				//        Debug.Print(A2(0))
				//        Debug.Print(A2(1))
				//        Debug.Print("______")
				//    End If
				//Next
				
				
				//Display the Title, letting UltraID3 determine the appropriate tag source
				string SongTitle = UD.Title;
				string Album = UD.Album;
				string Artist = UD.Artist;
				//Dim Duration As TimeSpan = UD.Duration.ToString
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
				
				
				
				//B = UD.ID3v2Tag.ExistsInFile
				//If B Then
				//    Debug.Print(UD.ID3v2Tag.ToString)
				//    Dim ID3v2GenreName = UD.ID3v1Tag.GenreName
				//    Dim ID3v2Genre = UD.ID3v1Tag.Genre
				//    Dim ID3v2GenreLyrics3v2WasFound As Boolean = UD.ID3v1Tag.Lyrics3v2WasFound
				//    Dim ID3v2Title = UD.ID3v1Tag.Title
				//    Dim ID3v2TrackNum = UD.ID3v1Tag.TrackNum
				//    Dim ID3v2Year = UD.ID3v1Tag.Year
				//    Dim Comments  = UD.ID3v1Tag.Comments
				//End If
				
				
				//If UD.ID3v1Tag.ExistsInFile Then
				//    'Display the Title property of the ID3v1Tag directly
				//    Debug.Print(UD.ID3v1Tag.ToString)
				//    Dim ID3v1GenreName = UD.ID3v1Tag.GenreName
				//    Dim ID3v1Genre = UD.ID3v1Tag.Genre
				//    Dim ID3v1GenreLyrics3v2WasFound As Boolean = UD.ID3v1Tag.Lyrics3v2WasFound
				//    Dim ID3v1Title = UD.ID3v1Tag.Title
				//    Dim ID3v1TrackNum = UD.ID3v1Tag.TrackNum
				//    Dim ID3v1Year = UD.ID3v1Tag.Year
				//    Dim Comments  = UD.ID3v1Tag.Comments
				
				
				//End If
				
				
				//'Retrieve any non-fatal exceptions which might have occurred
				//Dim E() = UD.GetExceptions()
				
				
				//If E.Length > 0 Then
				//    'Dim IndexUltraID3TagException As UltraID3TagException
				//    'Iterate through each found non-fatal exception
				//    For Each S As String In E
				//        'Display the Message of the non-fatal exception
				//        Debug.Print(E.ToString)
				//    Next
				
				
				//End If
				
				
				//Catch any fatal exceptions
			}
			catch (Exception exc)
			{
				LOG.WriteToArchiveLog((string) ("ERROR in processing MP3 Metadata: " + exc.Message));
				LOG.WriteToArchiveLog((string) ("clsMP3 : getMetaData : 224 Filename: " + FQN));
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
				{
					Debug.Print(tkey + ":" + tVal);
				}
				if (tkey.Length > 0 && tVal.Length > 0)
				{
					sAttr.setAttributename(ref tkey);
					sAttr.setAttributevalue(ref tVal);
					sAttr.setSourceguid(ref DocGuid);
					sAttr.setDatasourceowneruserid(ref modGlobals.gCurrUserGuidID);
					sAttr.setSourcetypecode(ref FileType);
					bool bb = DB.ItemExists("Attributes", "AttributeName", tkey, "C");
					if (bb == false)
					{
						DFLT.addDefaultAttributes(tkey, DataType, "Auto added: initWordDocMetaData", FileType);
					}
					bb = sAttr.Insert();
					if (! bb)
					{
						Debug.Print("ERROR XX23.01: failed to add metadata.");
					}
				}
			}
			catch (Exception ex)
			{
				if (ddebug)
				{
					Debug.Print(ex.Message);
				}
				DB.xTrace(23946, "Error 23977.1 : ABORT - Document Issue.", (string) ("Failed to add Metedata for: " + DB.getFilenameByGuid(DocGuid)), ex);
				LOG.WriteToArchiveLog((string) ("clsMP3 : AddMetaData : 242 : " + ex.Message));
			}
		}
	}
	
	
	
}
