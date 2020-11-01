Imports System
Imports System.IO
Imports System.Runtime.InteropServices
Imports System.ComponentModel


Public Class clsID3V1Tag
    Public title, artist, album, genre, comment As String
    Public year, track As Integer
    Private stream As FileStream
    Private br As BinaryReader

    Dim DMA As New clsDma
    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging


#Region "Genre Strings"
    Private genres() As String = {"Blues", "Classic Rock", "Country", "Dance", _
      "Disco", "Funk", "Grunge", "Hip-Hop", _
      "Jazz", "Metal", "New Age", "Oldies", _
      "Other", "Pop", "R&B", "Rap", _
      "Reggae", "Rock", "Techno", "Industrial", _
      "Alternative", "Ska", "Death Metal", "Pranks", _
      "Soundtrack", "Euro-Techno", "Ambient", "Trip-Hop", _
      "Vocal", "Jazz+Funk", "Fusion", "Trance", _
      "Classical", "Instrumental", "Acid", "House", _
      "Game", "Sound Clip", "Gospel", "Noise", _
      "Alt. Rock", "Bass", "Soul", "Punk", _
      "Space", "Meditative", "Instrumental Pop", "Instrumental Rock", _
      "Ethnic", "Gothic", "Darkwave", "Techno-Industrial", _
      "Electronic", "Pop-Folk", "Eurodance", "Dream", _
      "Southern Rock", "Comedy", "Cult", "Gangsta Rap", _
      "Top 40", "Christian Rap", "Pop/Funk", "Jungle", _
      "Native American", "Cabaret", "New Wave", "Psychedelic", _
      "Rave", "Showtunes", "Trailer", "Lo-Fi", _
      "Tribal", "Acid Punk", "Acid Jazz", "Polka", _
      "Retro", "Musical", "Rock & Roll", "Hard Rock", _
      "Folk", "Folk/Rock", "National Folk", "Swing", _
      "Fast-Fusion", "Bebop", "Latin", "Revival", _
      "Celtic", "Bluegrass", "Avantgarde", "Gothic Rock", _
      "Progressive Rock", "Psychedelic Rock", "Symphonic Rock", "Slow Rock", _
      "Big Band", "Chorus", "Easy Listening", "Acoustic", _
      "Humour", "Speech", "Chanson", "Opera", _
      "Chamber Music", "Sonata", "Symphony", "Booty Bass", _
      "Primus", "Porn Groove", "Satire", "Slow Jam", _
      "Club", "Tango", "Samba", "Folklore", _
      "Ballad", "Power Ballad", "Rhythmic Soul", "Freestyle", _
      "Duet", "Punk Rock", "Drum Solo", "A Cappella", _
      "Euro-House", "Dance Hall", "Goa", "Drum & Bass", _
      "Club-House", "Hardcore", "Terror", "Indie", _
      "BritPop", "Negerpunk", "Polsk Punk", "Beat", _
      "Christian Gangsta Rap", "Heavy Metal", "Black Metal", "Crossover", _
      "Contemporary Christian", "Christian Rock", "Merengue", "Salsa", "Thrash Metal"}
#End Region
    Public Sub New(ByVal fn As String)
        Reset()
        Dim ch() As Char
        Dim b As Byte
        Dim s As String


        Try
            stream = New FileStream(fn, FileMode.Open)
            br = New BinaryReader(stream)
        Catch ex As Exception
            Debug.Print(ex.Message)
            stream.Close()
            log.WriteToArchiveLog("clsID3V1Tag : New : 9 : " + ex.Message)
            Return
        End Try


        Try
            stream.Seek(-128, SeekOrigin.End)


            ReDim ch(2)
            ch = br.ReadChars(3)
            If Not New String(ch) = "TAG" Then
                Throw New Exception("No Valid ID3V1.1 tag information")
                stream.Close()
                Return
            End If


            ReDim ch(29)
            ch = br.ReadChars(30)
            title = New String(ch)
            ch = br.ReadChars(30)
            artist = New String(ch)
            ch = br.ReadChars(30)
            album = New String(ch)
            ReDim ch(3)
            ch = br.ReadChars(4)
            s = New String(ch)
            If IsNumeric(s) Then
                year = CInt(s)
            Else
                year = 0
            End If
            ReDim ch(27)
            ch = br.ReadChars(28)
            comment = New String(ch)
            b = br.ReadByte
            b = br.ReadByte
            track = CInt(b)
            b = br.ReadByte
            genre = genres(CInt(b))
        Catch ex As Exception
            Throw New Exception("ID3 V1.1 tag information not valid in " & fn)
            log.WriteToArchiveLog("clsID3V1Tag : New : 44 : " + ex.Message)
        Finally
            br.Close()
            stream.Close()
        End Try
    End Sub
End Class
