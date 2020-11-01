using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.InteropServices;
using System.Diagnostics;
using System.Security.Cryptography;
using System.Data.SQLite;
using ECMEncryption;

namespace ArchiverFileMgt
{

    /// <summary>Provides local machine Archive management</summary>
    public static class ArchFileMgt
    {

        [DllImport("kernel32.dll", CharSet = CharSet.Auto, SetLastError = true)]
        static extern uint GetShortPathName(string lpszLongPath, char[] lpszShortPath, int cchBuffer);

        private static Dictionary<string,int> ListOfFiles = new Dictionary<string, int>();
        private static Dictionary<string, int> ListOfDirs = new Dictionary<string, int>();
        private static SQLiteConnection gConn = null;
        private static string gConnstr = "";

        /// <summary>Sets the connection.</summary>
        private static void SetConnection()
        {
            if (gConn == null)
            {
                CreateDb();
                BuildDB DB = new BuildDB();
                gConnstr = DB.VerifyDB();
                gConn = CreateConnection();
                DB = null;
            }
        }

        /// <summary>Gets the local files from local storage.</summary>
        private static void GetLocalFiles()
        {
            SQLiteConnection conn = CreateConnection();
            if (ListOfFiles.Count == 0)
                ListOfFiles = FILETBL.GetExistingRecs(conn);
            if (ListOfDirs.Count == 0)
                ListOfDirs = DIRTBL.GetExistingRecs(conn);
        }

        /// <summary>
        /// Returns file names from given folder that comply to given filters
        /// </summary>
        /// <param name="SourceFolder">Folder with files to retrieve</param>
        /// <param name="Filter">Multiple file filters separated by | character</param>
        /// <param name="searchOption">File.IO.SearchOption,
        /// could be AllDirectories or TopDirectoryOnly</param>
        /// <returns>Array of FileInfo objects that presents collection of file names that
        /// meet given filter</returns>
        private static string[] GetLocalFiles(string SourceFolder, string Filter, System.IO.SearchOption searchOption)
        {
            //decimal pct = 0;
            SetConnection();
            GetLocalFiles();

            // ArrayList will hold all file names
            ArrayList alFiles = new ArrayList();

            // Create an array of filter string
            string[] MultipleFilters = Filter.Split('|');

            // for each filter find mathing file names
            foreach (string FileFilter in MultipleFilters)
            {
                // add found file names to array list
                alFiles.AddRange(Directory.GetFiles(SourceFolder, FileFilter, searchOption));
            }

            // returns string array of relevant file names
            return (string[])alFiles.ToArray(typeof(string));
        }

        /// <summary>Gets the files to archive.</summary>
        /// <param name="DirName">Name of the dir.</param>
        /// <param name="IncludeSubDir">if set to <c>true</c> [include sub dir].</param>
        /// <param name="FileExts">The file exts.</param>
        /// <returns></returns>
        public static List<string> getFilesToArchive(string DirName, bool IncludeSubDir, List<string> FileExts)
        {
            bool dbug = true;
            DateTime stime = DateTime.Now;
            Console.WriteLine("START TIME: " + DateTime.Now.ToString());

            ECMEncrypt ENC = new ECMEncrypt();
            SQLiteConnection gConn = CreateConnection();
            SetConnection();
            GetLocalFiles();

            if (gConn == null)
            gConn = CreateConnection();

            Dictionary<string, string> RowParms = new Dictionary<string, string>();

            FileExts = FileExts.ConvertAll(d => d.ToLower());
            string exts = string.Join(",", FileExts);

            SearchOption SO = SearchOption.TopDirectoryOnly;
            if (IncludeSubDir.Equals(true))
            {
                SO = SearchOption.AllDirectories;
            }

            DirectoryInfo di = new DirectoryInfo(DirName);

            string fqn = "";
            string fpath = "";
            string fname = "";
            string flen = "";
            string fdate = "";
            string tcode = "";
            List<string> FilesToArchive = new List<string>();

            string[] dirs = Directory.GetDirectories(DirName, "*.*", SO);
            Int32 totcnt = 0;
            decimal currcnt = 0;
            decimal dircnt = dirs.Length;
            Int32 iCnt = dirs.Length;
            string filehash = "";
            foreach (string tgtdir in dirs)
            {
                try
                {
                    currcnt += 1;
                    if (currcnt % 50 == 0)
                    {
                        decimal pct = Math.Round( currcnt  / dircnt * 100, 2);
                        if (dbug == true)
                        {
                            Console.Write("\r{0}%   ", pct);
                            //Console.WriteLine("Dir #" + currcnt.ToString() + " of " + dircnt.ToString());
                            //Console.WriteLine("Files #" + totcnt.ToString());
                        }
                    }
                    
                    di = new DirectoryInfo(tgtdir);
                    foreach (var fi in di.GetFiles())
                    {
                        fpath = fi.DirectoryName;
                        fname = fi.Name;
                        fqn = fi.FullName;
                        flen = fi.Length.ToString();
                        fdate = fi.LastWriteTime.ToString();

                        tcode = fqn + flen + fdate;
                        filehash = GenHash(tcode);

                        totcnt += 1;

                        if (FileExts.Equals(null) | FileExts.Contains(fi.Extension))
                        {

                            int FileID = ListOfFiles[fname.ToUpper()];
                            int DirID = ListOfDirs[fpath.ToUpper()];
                            string fqnhash = ENC.getSha1HashKey(fqn.ToUpper());
                            int x = INV.RecExists(gConn, DirID, FileID);

                            if (x > 0)
                            {
                                bool budpt = INV.CheckUpdateNeeded(gConn,DirID, FileID, fi.Length, fi.LastWriteTime);
                                if (budpt == true)
                                {
                                    INV.UpdateCol(gConn,DirID,FileID, "NeedsArchive", "true");
                                    FilesToArchive.Add(fi.FullName);
                                }
                            }
                            else
                            {   //We need to add it to inventory
                                Dictionary<string, string> ControlParms = new Dictionary<string, string>();
                                ControlParms.Add("InvID", "0");
                                ControlParms.Add("DirID", DirID.ToString());
                                ControlParms.Add("FileID", FileID.ToString());
                                ControlParms.Add("FileExist", "1");
                                ControlParms.Add("FileSize", fi.Length.ToString());
                                ControlParms.Add("CreateDate", fi.CreationTime.ToString());
                                ControlParms.Add("LastUpdate", fi.LastWriteTime.ToString());
                                ControlParms.Add("LastArchiveUpdate", DateTime.Now.ToString());
                                ControlParms.Add("ArchiveBit", "0");
                                ControlParms.Add("NeedsArchive", "1");
                                ControlParms.Add("FileHash", fqnhash);
                                bool bb = INV.InsertRec(gConn, ControlParms);
                                if (bb == false)
                                {
                                    Console.WriteLine("ERROR: Failed to write inventory file: " + fqn);
                                }
                            }

                            if ((fi.Attributes & FileAttributes.Archive) == FileAttributes.Archive)
                            {
                                //if (!ListOfFiles.Contains(fname))
                                //{
                                //    string ilen = flen;
                                //    string crc = GetChecksum(fqn);
                                //}

                                if (!ListOfDirs.Keys.Contains(fpath.ToUpper()))
                                {
                                    RowParms.Clear();
                                    RowParms.Add("DirName", fpath);
                                    RowParms.Add("DirID", "0");
                                    RowParms.Add("DirHash", ENC.getSha1HashKey(fpath.ToUpper()));
                                    RowParms.Add("UseArchiveBit", "1");
                                    int ID = DIRTBL.MergeRec(gConn, RowParms);
                                    RowParms.Clear();
                                    ListOfDirs.Add(fpath.ToUpper(), ID);
                                }
                                if (!ListOfFiles.Keys.Contains(fname.ToUpper()))
                                {
                                    RowParms.Clear();
                                    RowParms.Add("FileName", fname);
                                    RowParms.Add("FileID", "0");
                                    RowParms.Add("FileHash", ENC.getSha1HashKey(fname.ToUpper()));
                                    int ID = FILETBL.MergeRec(gConn, RowParms);
                                    RowParms.Clear();
                                    ListOfFiles.Add(fname.ToUpper(), ID);
                                }
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    if (File.Exists(fqn))
                    {
                        fname = Path.GetFileName(fqn);
                        fpath = Path.GetDirectoryName(fqn);
                        int i = fqn.LastIndexOf('.');
                        string fext = Path.GetExtension(fname);

                        if (!ListOfDirs.Keys.Contains(fpath.ToUpper()))
                        {
                            RowParms.Clear();
                            RowParms.Add("DirName", fpath);
                            RowParms.Add("DirID", "0");
                            RowParms.Add("DirHash", ENC.getSha1HashKey(fpath.ToUpper()));
                            RowParms.Add("UseArchiveBit", "1");
                            int ID = DIRTBL.MergeRec(gConn, RowParms);
                            RowParms.Clear();
                            ListOfDirs.Add(fpath.ToUpper(), ID);
                        }
                        if (!ListOfFiles.Keys.Contains(fname.ToUpper()))
                        {
                            RowParms.Clear();
                            RowParms.Add("FileName", fname);
                            RowParms.Add("FileID", "0");
                            RowParms.Add("FileHash", ENC.getSha1HashKey(fname.ToUpper()));
                            int ID = FILETBL.MergeRec(gConn, RowParms);
                            RowParms.Clear();
                            ListOfFiles.Add(fname.ToUpper(),ID);
                        }


                        if (i > 0)
                        {
                            if (FileExts.Contains(fext.ToLower()))
                            {
                                //tcode = fqn + flen + flen + fdate;
                                //filehash = GenHash(tcode);
                                //byte[] fbytes = File.ReadAllBytes(fqn);
                                //int ilen = fbytes.Length;
                                //fbytes = null;
                                //string crc = GetChecksum(fqn);
                                
                                FilesToArchive.Add(fqn);
                            }
                        }
                    }
                    else
                    {
                        Console.WriteLine(ex.Message);
                    }
                }
                finally
                {
                    di = null;
                }
            }
            
            Console.WriteLine("#Files Evaluated: " + totcnt.ToString());
            Console.WriteLine("#Files To Archive: " + FilesToArchive.Count.ToString());
            Console.WriteLine("END TIME: " + DateTime.Now.ToString());
            
            var diffInSeconds = ( DateTime.Now - stime).TotalSeconds;
            Console.WriteLine("Elapsed TIME: " + diffInSeconds.ToString() + "sec");
            return FilesToArchive;
        }

        /// <summary>Sets the archive bit.</summary>
        /// <param name="RowID">The row identifier.</param>
        /// <param name="BitValue">if set to <c>true</c> [bit value].</param>
        /// <returns></returns>
        public static bool SetArchiveBit(int RowID, bool BitValue)
        {
            SetConnection();
            return INV.SetArchiveBit(gConn, RowID, BitValue);
        }

        // Return the short file name for a long file name.
        private static string ShortFileName(string long_name)
        {
            char[] name_chars = new char[1024];
            long length = GetShortPathName(
                long_name, name_chars,
                name_chars.Length);

            string short_name = new string(name_chars);
            return short_name.Substring(0, (int)length);
        }

        /// <summary>Gets the checksum.</summary>
        /// <param name="file">The file.</param>
        /// <returns>CRC of the file</returns>
        private static string GetChecksum(string file)
        {
            using (FileStream stream = File.OpenRead(file))
            {
                var sha = new SHA256Managed();
                byte[] checksum = sha.ComputeHash(stream);
                return BitConverter.ToString(checksum).Replace("-", String.Empty);
            }
        }
        /// <summary>Gens the hash.</summary>
        /// <param name="str">The string.</param>
        /// <returns>hash of passed in string</returns>
        private static string GenHash(string str)
        {
            var sha = new SHA256Managed();
            byte[] bstr = Encoding.ASCII.GetBytes(str);
            byte[] checksum = sha.ComputeHash(bstr);
            return BitConverter.ToString(checksum).Replace("-", String.Empty);
        }

        static private SQLiteConnection CreateConnection()
        {
            if (gConn != null)
            {
                return gConn;
            }

            if (gConnstr.Length == 0)
            {
                BuildDB DB = new BuildDB();
                gConnstr = DB.VerifyDB();
                DB = null;
            }

            // Create a new database connection:
            gConn = new SQLiteConnection(gConnstr);
            // Open the connection:
            try
            {
                gConn.Open();
            }
            catch (Exception ex)
            {
                Console.WriteLine("ERROR CreateConnection 2201: " + ex.Message);
            }
            return gConn;
        }

        /// <summary>Creates the local SQL Lite database if it does not exist.</summary>
        public static void CreateDb()
        {
            BuildDB DB = new BuildDB();
            DB.VerifyDB();
            DB = null;
        }
    }
}
