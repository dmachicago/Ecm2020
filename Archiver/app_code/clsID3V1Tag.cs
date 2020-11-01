using global::System;
using System.Diagnostics;
using global::System.IO;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public class clsID3V1Tag
    {
        public string title, artist, album, genre, comment;
        public int year, track;
        private FileStream stream;
        private BinaryReader br;
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();


        /* TODO ERROR: Skipped RegionDirectiveTrivia */
        private string[] genres = new string[] { "Blues", "Classic Rock", "Country", "Dance", "Disco", "Funk", "Grunge", "Hip-Hop", "Jazz", "Metal", "New Age", "Oldies", "Other", "Pop", "R&B", "Rap", "Reggae", "Rock", "Techno", "Industrial", "Alternative", "Ska", "Death Metal", "Pranks", "Soundtrack", "Euro-Techno", "Ambient", "Trip-Hop", "Vocal", "Jazz+Funk", "Fusion", "Trance", "Classical", "Instrumental", "Acid", "House", "Game", "Sound Clip", "Gospel", "Noise", "Alt. Rock", "Bass", "Soul", "Punk", "Space", "Meditative", "Instrumental Pop", "Instrumental Rock", "Ethnic", "Gothic", "Darkwave", "Techno-Industrial", "Electronic", "Pop-Folk", "Eurodance", "Dream", "Southern Rock", "Comedy", "Cult", "Gangsta Rap", "Top 40", "Christian Rap", "Pop/Funk", "Jungle", "Native American", "Cabaret", "New Wave", "Psychedelic", "Rave", "Showtunes", "Trailer", "Lo-Fi", "Tribal", "Acid Punk", "Acid Jazz", "Polka", "Retro", "Musical", "Rock & Roll", "Hard Rock", "Folk", "Folk/Rock", "National Folk", "Swing", "Fast-Fusion", "Bebop", "Latin", "Revival", "Celtic", "Bluegrass", "Avantgarde", "Gothic Rock", "Progressive Rock", "Psychedelic Rock", "Symphonic Rock", "Slow Rock", "Big Band", "Chorus", "Easy Listening", "Acoustic", "Humour", "Speech", "Chanson", "Opera", "Chamber Music", "Sonata", "Symphony", "Booty Bass", "Primus", "Porn Groove", "Satire", "Slow Jam", "Club", "Tango", "Samba", "Folklore", "Ballad", "Power Ballad", "Rhythmic Soul", "Freestyle", "Duet", "Punk Rock", "Drum Solo", "A Cappella", "Euro-House", "Dance Hall", "Goa", "Drum & Bass", "Club-House", "Hardcore", "Terror", "Indie", "BritPop", "Negerpunk", "Polsk Punk", "Beat", "Christian Gangsta Rap", "Heavy Metal", "Black Metal", "Crossover", "Contemporary Christian", "Christian Rock", "Merengue", "Salsa", "Thrash Metal" };


































        /* TODO ERROR: Skipped EndRegionDirectiveTrivia */
        public clsID3V1Tag(string fn)
        {
            FileSystem.Reset();
            char[] ch;
            byte b;
            string s;
            try
            {
                stream = new FileStream(fn, FileMode.Open);
                br = new BinaryReader(stream);
            }
            catch (Exception ex)
            {
                Debug.Print(ex.Message);
                stream.Close();
                LOG.WriteToArchiveLog("clsID3V1Tag : New : 9 : " + ex.Message);
                return;
            }

            try
            {
                stream.Seek(-128, SeekOrigin.End);
                ch = new char[3];
                ch = br.ReadChars(3);
                if (!(new string(ch) == "TAG"))
                {
                    throw new Exception("No Valid ID3V1.1 tag information");
                    stream.Close();
                    return;
                }

                ch = new char[30];
                ch = br.ReadChars(30);
                title = new string(ch);
                ch = br.ReadChars(30);
                artist = new string(ch);
                ch = br.ReadChars(30);
                album = new string(ch);
                ch = new char[4];
                ch = br.ReadChars(4);
                s = new string(ch);
                if (Information.IsNumeric(s))
                {
                    year = Conversions.ToInteger(s);
                }
                else
                {
                    year = 0;
                }

                ch = new char[28];
                ch = br.ReadChars(28);
                comment = new string(ch);
                b = br.ReadByte();
                b = br.ReadByte();
                track = b;
                b = br.ReadByte();
                genre = genres[b];
            }
            catch (Exception ex)
            {
                throw new Exception("ID3 V1.1 tag information not valid in " + fn);
                LOG.WriteToArchiveLog("clsID3V1Tag : New : 44 : " + ex.Message);
            }
            finally
            {
                br.Close();
                stream.Close();
            }
        }
    }
}