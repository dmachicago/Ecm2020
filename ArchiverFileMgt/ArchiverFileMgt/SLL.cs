using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Security;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Data.SQLite;
using ECMEncryption;
using Microsoft.VisualBasic;
using System.Collections;
using System.Data;

namespace ArchiverFileMgt
{
    /// <summary>
    /// Manages the LOCAL SQL Lite database
    /// </summary>
    public static class SLL
    {
        static private SQLiteConnection CONN = new SQLiteConnection();
        static private string CS = "";
        private static string LiteDBPath = "";
        public static string gDBPath = "";

        /// <summary>
        /// Initializes the database.
        /// </summary>
        /// <returns>Active Connection </returns>
        public static SQLiteConnection InitDB()
        {

            string tPath = System.IO.Path.GetTempPath();
            tPath = tPath + @"EcmLibrary\SqlLiteDB";
            LiteDBPath = tPath;
            
            CopyDatabases();

            if (!File.Exists(LiteDBPath + @"\EcmArchive.db"))
                Console.WriteLine("MISSING: " + LiteDBPath + @"\EcmArchive.db");
            //C:\Users\wdale\AppData\Local\Temp\EcmLibrary\SqlLiteDB\EcmArchive.db
            string str = LiteDBPath + @"\EcmArchive.db";
            CS = GetCS(str);
            CONN = CreateSQLiteConnection();
            return CONN;
        }

        /// <summary>
        /// Creates the sq lite connection.
        /// </summary>
        /// <returns></returns>
        public static SQLiteConnection CreateSQLiteConnection()
        {
            SQLiteConnection sqlite_conn;
            // Create a new database connection:
            sqlite_conn = new SQLiteConnection(GetCS(CS));
            // Open the connection:
            try
            {
                sqlite_conn.Open();
            }
            catch (Exception ex)
            {
                Console.WriteLine("ERROR CreateConnection 2201: " + ex.Message);
            }
            return sqlite_conn;
        }

        /// <summary>
        /// Gets the cs.
        /// </summary>
        /// <param name="fqn">The FQN.</param>
        /// <returns>Connection string</returns>
        public static string GetCS(string fqn)
        {
            if (File.Exists(gDBPath))
            {
                fqn = gDBPath;
            }
            else
            {
                CopyDatabases();
                fqn = gDBPath;
            }
            return "Data Source= "+fqn+"; Version = 3; New = True; Compress = True; ";
        }

        /// <summary>
        /// Copies the databases.
        /// </summary>
        public static void CopyDatabases()
        {
            if (Directory.Exists(LiteDBPath))
            {
            }
            else
                Directory.CreateDirectory(LiteDBPath);

            FindCeDatabase(LiteDBPath);
        }

        /// <summary>
        /// Finds the ce database.
        /// </summary>
        /// <param name="NewPath">The new path.</param>
        /// <returns></returns>
        public static string FindCeDatabase(string NewPath)
        {
            if (gDBPath.Length > 0)
            {
                return gDBPath;
            }
            string S = "";
            string NewCE = "";

            List<string> listOfFiles = new List<string>();
            listOfFiles = findSQLiteDB(NewPath, true);

            string slfqn = @"..\SqlLiteDB\EcmArchive.db";
            bool bbb = File.Exists(slfqn);

            string assemblyFolder = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
            slfqn = assemblyFolder + @"\SqlLiteDB\EcmArchive.db";

            if (listOfFiles.Count == 0)
            {
                listOfFiles = findSQLiteDB(assemblyFolder, true);
            }
            
            foreach (string fName in listOfFiles)
            {
                NewCE = NewPath + @"\" + "EcmArchive.db";
                if (!File.Exists(NewCE))
                {
                    File.Copy(fName, NewCE);
                    S = NewCE;
                    gDBPath = NewCE;
                    break;
                }
                else
                {
                    S = NewCE;
                }
            }

            return S;
        }

        /// <summary>
        /// Finds the sq lite database.
        /// </summary>
        /// <param name="DirName">Name of the dir.</param>
        /// <param name="IncludeSubDir">if set to <c>true</c> [include sub dir].</param>
        /// <returns></returns>
        public static List<string> findSQLiteDB(string DirName, bool IncludeSubDir)
        {

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
            List<string> FoundFiles = new List<string>();
            string[] dirs = Directory.GetDirectories(DirName, "*.*", SO);
            bool bFound = false;
            foreach (string tgtdir in dirs)
            {
                try
                {
                    di = new DirectoryInfo(tgtdir);
                    foreach (var fi in di.GetFiles())
                    {
                        fpath = fi.DirectoryName;
                        fname = fi.Name;
                        fqn = fi.FullName;
                        flen = fi.Length.ToString();
                        fdate = fi.LastWriteTime.ToString();

                        if (fname.ToUpper().Equals("ECMARCHIVE.DB"))
                        {
                            FoundFiles.Add(fi.FullName);
                            gDBPath = fi.FullName;
                            bFound = true;
                            break;
                        }
                    }
                    if (bFound == true)
                    {
                        break;
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("ERROR SL01: " + ex.Message);
                }
                finally
                {
                    di = null;
                }
            }

            return FoundFiles;
        }

        /// <summary>
        /// Inventories the dir.
        /// </summary>
        /// <param name="DirName">Name of the dir.</param>
        /// <param name="bUseArchiveBit">if set to <c>true</c> [b use archive bit].</param>
        public static void InventoryDir(string DirName, bool bUseArchiveBit)
        {
            bool B = true;
            int DirID = GetDirID(DirName);
            if (DirID < 0)
            {
                B = addDir(DirName, bUseArchiveBit);
                if (!B)
                    LOG.WriteToArchiveLog("ERROR: clsDbLocal/InventoryDir - Failed to inventory directory '" + DirName + "'.");
            }
        }

        /// <summary>
        /// Adds the dir.
        /// </summary>
        /// <param name="FQN">The FQN.</param>
        /// <param name="bUseArchiveBit">if set to <c>true</c> [b use archive bit].</param>
        /// <returns></returns>
        public static bool addDir(string FQN, bool bUseArchiveBit)
        {
            bool B = true;
            int UseArchiveBit = 0;
            if (bUseArchiveBit)
                UseArchiveBit = 1;

            string S = "Insert into Directory (DirName,UseArchiveBit) values ('" + FQN + "', " + UseArchiveBit.ToString() + ") ";

            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS("");
                CONN.Open();
            }

            // Dim cmd As New SQLiteCommand(S, cn)
            try
            {
                SQLiteCommand cmd = CONN.CreateCommand();
                cmd.CommandText = S;
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/addDir - " + ex.Message + Environment.NewLine + S);
                B = false;
            }
            finally
            {
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }

            return B;
        }


        /// <summary>
        /// Inventories the file.
        /// </summary>
        /// <param name="FileName">Name of the file.</param>
        /// <param name="FileHash">The file hash.</param>
        public static void InventoryFile(string FileName, string FileHash)
        {
            bool B = true;
            int FileID = GetFileID(FileName, FileHash);
            if (FileID < 0)
            {
                B = addFile(FileName, FileHash);
                if (!B)
                    LOG.WriteToArchiveLog("ERROR: clsDbLocal/InventoryDir - Failed to inventory file '" + FileName + "'.");
            }
        }

        /// <summary>
        /// Gets the file identifier.
        /// </summary>
        /// <param name="FileName">Name of the file.</param>
        /// <param name="FileHash">The file hash.</param>
        /// <returns></returns>
        public static int GetFileID(string FileName, string FileHash)
        {
            FileName = FileName.Replace("'", "''");
            int FileID = -1;
            string S = "Select FileID from Files where FileName = '" + FileName + "' and Filehash = '" + FileHash + "' ";

            // Dim cn As New SQLiteConnection(GetCS(""))

            try
            {
                if (CONN.State == ConnectionState.Closed)
                {
                    CONN.ConnectionString = GetCS("");
                    CONN.Open();
                }

                SQLiteCommand cmd = new SQLiteCommand(S, CONN);
                cmd.CommandType = CommandType.Text;

                // ** if you don’t set the result set to scrollable HasRows does not work
                // Dim rs As SQLiteDataReader = cmd.ExecuteReader()
                SQLiteDataReader rs = cmd.ExecuteReader();

                if (rs.HasRows)
                {
                    rs.Read();
                    FileID = rs.GetInt32(0);
                }
                else
                    FileID = -1;

                if (!rs.IsClosed)
                    rs.Close();
                rs.Dispose();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/GetDirID - " + ex.Message + Environment.NewLine + S);
                FileID = -1;
            }
            finally
            {
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();

            return FileID;
        }

        /// <summary>
        /// Adds the file.
        /// </summary>
        /// <param name="FileName">Name of the file.</param>
        /// <param name="FileHash">The file hash.</param>
        /// <returns></returns>
        public static bool addFile(string FileName, string FileHash)
        {
            bool B = true;
            //int UseArchiveBit = 0;
            string S = "Insert into Files (FileName, FileHash) values (@FileName, @FileHash) ";

            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS("");
                CONN.Open();
            }

            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.Parameters.AddWithValue("@FileName", FileName);
                cmd.Parameters.AddWithValue("@FileHash", FileHash);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/addFile - " + ex.Message + Environment.NewLine + S);
                B = false;
            }
            finally
            {
                cmd.Dispose();
                // If cn IsNot Nothing Then
                // If cn.State = ConnectionState.Open Then
                // cn.Close()
                // End If
                // cn.Dispose()
                // End If
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }

            return B;
        }

        /// <summary>
        /// Adds the contact.
        /// </summary>
        /// <param name="FullName">The full name.</param>
        /// <param name="Email1Address">The email1 address.</param>
        /// <returns></returns>
        public static bool addContact(string FullName, string Email1Address)
        {
            if (Email1Address == null)
                Email1Address = "NA";

            bool B = true;
            //int UseArchiveBit = 0;

            string S = "Insert into ContactsArchive (Email1Address, FullName) values (@Email1Address, @FullName) ";

            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS("");
                CONN.Open();
            }

            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.Parameters.AddWithValue("@Email1Address", Email1Address);
                cmd.Parameters.AddWithValue("@FullName", FullName);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/addContact - " + ex.Message + Environment.NewLine + S);
                B = false;
            }
            finally
            {
                cmd.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }

            return B;
        }

        /// <summary>
        /// Files the exists.
        /// </summary>
        /// <param name="FileName">Name of the file.</param>
        /// <returns></returns>
        public static bool fileExists(string FileName)
        {
            bool B = false;
            string S = "Select count(*) from Files where FileName = '" + FileName + "' ";
            // Dim cn As New SQLiteConnection(GetCS)
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS("");
                CONN.Open();
            }

            int iCnt = 0;
            try
            {
                SQLiteCommand cmd = new SQLiteCommand(S, CONN);
                cmd.CommandType = CommandType.Text;

                // ** if you don’t set the result set to scrollable HasRows does not work
                SQLiteDataReader rs = cmd.ExecuteReader();

                if (rs.HasRows)
                {
                    rs.Read();
                    iCnt = rs.GetInt32(0);
                }
                else
                    iCnt = 0;

                if (!rs.IsClosed)
                    rs.Close();
                rs.Dispose();

                if (iCnt > 0)
                    B = true;
                else
                    B = false;
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/fileExists - " + ex.Message + Environment.NewLine + S);
                B = false;
            }
            finally
            {
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();

            return B;
        }

        /// <summary>
        /// Contacts the exists.
        /// </summary>
        /// <param name="FullName">The full name.</param>
        /// <param name="Email1Address">The email1 address.</param>
        /// <returns></returns>
        public static bool contactExists(string FullName, string Email1Address)
        {
            bool B = false;
            string S = "Select count(*) from ContactsArchive where Email1Address = '" + Email1Address + "' and FullName = '" + FullName + "' ";

            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS("");
                CONN.Open();
            }

            int iCnt = 0;
            try
            {
                SQLiteCommand cmd = new SQLiteCommand(S, CONN);
                cmd.CommandType = CommandType.Text;

                // ** if you don’t set the result set to scrollable HasRows does not work
                SQLiteDataReader rs = cmd.ExecuteReader();

                if (rs.HasRows)
                {
                    rs.Read();
                    iCnt = rs.GetInt32(0);
                }
                else
                    iCnt = 0;

                if (!rs.IsClosed)
                    rs.Close();
                rs.Dispose();

                if (iCnt > 0)
                    B = true;
                else
                    B = false;
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/contactExists - " + ex.Message + Environment.NewLine + S);
                B = false;
            }
            finally
            {
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();

            return B;
        }

        /// <summary>
        /// Gets the dir identifier.
        /// </summary>
        /// <param name="DirName">Name of the dir.</param>
        /// <returns></returns>
        public static int GetDirID(string DirName)
        {
            DirName = DirName.Replace("'", "''");
            int DirID = -1;
            string S = "Select DirID from Directory where DirName = '" + DirName + "' ";
            // Dim cn As New SQLiteConnection(GetCS(""))

            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS("");
                CONN.Open();
            }

            SQLiteCommand cmd = CONN.CreateCommand();
            try
            {
                cmd.CommandText = S;

                // ** if you don’t set the result set to scrollable HasRows does not work
                // Dim rs As SQLiteDataReader = cmd.ExecuteReader()
                SQLiteDataReader rs = cmd.ExecuteReader();
                cmd.ExecuteNonQuery();

                if (rs.HasRows)
                {
                    rs.Read();
                    DirID = rs.GetInt32(0);
                }
                else
                    DirID = -1;

                if (!rs.IsClosed)
                    rs.Close();
                rs.Dispose();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/GetDirID - " + ex.Message + Environment.NewLine + S);
                DirID = -1;
            }
            finally
            {
                cmd.Dispose();
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();

            return DirID;
        }

        /// <summary>
        /// Gets the dir identifier.
        /// </summary>
        /// <param name="DirName">Name of the dir.</param>
        /// <param name="UseArchiveBit">if set to <c>true</c> [use archive bit].</param>
        /// <returns></returns>
        public static int GetDirID(string DirName, ref bool UseArchiveBit)
        {
            UseArchiveBit = false;
            int DirID = -1;
            string S = "Select DirID,UseArchiveBit from Directory where DirName = '" + DirName + "' ";
            // Dim cn As New SQLiteConnection(GetCS(""))

            try
            {

                if (CONN.State == ConnectionState.Closed)
                {
                    CONN.ConnectionString = GetCS("");
                    CONN.Open();
                }

                SQLiteCommand cmd = new SQLiteCommand(S, CONN);
                cmd.CommandType = CommandType.Text;

                // ** if you don’t set the result set to scrollable HasRows does not work
                SQLiteDataReader rs = cmd.ExecuteReader();

                if (rs.HasRows)
                {
                    rs.Read();
                    DirID = System.Convert.ToInt32(rs.GetValue(0));
                    UseArchiveBit = rs.GetBoolean(1);
                }
                else
                {
                    UseArchiveBit = false;
                    DirID = -1;
                }

                if (!rs.IsClosed)
                    rs.Close();
                rs.Dispose();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/GetDirID - " + ex.Message + Environment.NewLine + S);
                DirID = -1;
            }
            finally
            {
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();

            return DirID;
        }

        /// <summary>
        /// Inventories the exists.
        /// </summary>
        /// <param name="DirID">The dir identifier.</param>
        /// <param name="FileID">The file identifier.</param>
        /// <param name="CRC">The CRC.</param>
        /// <returns></returns>
        public static bool InventoryExists(int DirID, int FileID, string CRC)
        {
            bool B = false;
            string S = "Select FileHash from Inventory where DirID = " + DirID.ToString() + " and FileID = " + FileID.ToString();
            // Dim cn As New SQLiteConnection(GetCS)
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS("");
                CONN.Open();
            }

            //int iCnt = 0;
            try
            {
                SQLiteCommand cmd = new SQLiteCommand(S, CONN);
                cmd.CommandType = CommandType.Text;

                // ** if you don’t set the result set to scrollable HasRows does not work
                SQLiteDataReader rs = cmd.ExecuteReader();

                if (rs.HasRows)
                {
                    rs.Read();
                    CRC = rs.GetString(0);
                    B = true;
                }
                else
                {
                    CRC = "";
                    B = false;
                }

                if (!rs.IsClosed)
                    rs.Close();
                rs.Dispose();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/InventoryExists - " + ex.Message + Environment.NewLine + S);
                CRC = "";
            }
            finally
            {
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();

            return B;
        }

        /// <summary>
        /// Inventories the hash compare.
        /// </summary>
        /// <param name="DirID">The dir identifier.</param>
        /// <param name="FileID">The file identifier.</param>
        /// <param name="CurrHash">The curr hash.</param>
        /// <returns></returns>
        public static bool InventoryHashCompare(int DirID, int FileID, string CurrHash)
        {
            bool B = false;
            string S = "Select FileHash from Inventory where DirID = X and FileID = X ";
            // Dim cn As New SQLiteConnection(GetCS)
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS("");
                CONN.Open();
            }

            string OldHash = "";
            try
            {
                SQLiteCommand cmd = new SQLiteCommand(S, CONN);
                cmd.CommandType = CommandType.Text;

                // ** if you don’t set the result set to scrollable HasRows does not work
                SQLiteDataReader rs = cmd.ExecuteReader();

                if (rs.HasRows)
                {
                    rs.Read();
                    OldHash = rs.GetValue(0).ToString();
                }
                else
                    OldHash = "";

                if (!rs.IsClosed)
                    rs.Close();
                rs.Dispose();

                if (CurrHash.Equals(OldHash))
                    B = true;
                else
                    B = false;
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/InventoryExists - " + ex.Message + Environment.NewLine + S);
                FileID = -1;
            }
            finally
            {
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();

            return B;
        }

        /// <summary>
        /// Sets the inventory archive.
        /// </summary>
        /// <param name="FQN">The FQN.</param>
        /// <param name="ArchiveFlag">if set to <c>true</c> [archive flag].</param>
        /// <param name="FileHash">The file hash.</param>
        /// <returns></returns>
        public static bool setInventoryArchive(string FQN, bool ArchiveFlag, string FileHash)
        {
            bool B = true;
            FileInfo FI = new FileInfo(FQN);
            string sDirName = "";
            string sFileName = "";
            try
            {
                sDirName = FI.DirectoryName;
                sFileName = FI.Name;
            }
            catch (Exception ex)
            {
                B = false;
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/setInventoryArchive 00 - " + ex.Message);
                return B;
            }

            int iArchiveFlag = 0;
            //int FileExist = 1;
            //int NeedsArchive = 1;
            //int UseArchiveBit = 0;
            int DirID = 0;
            int FileID = 0;

            DirID = GetDirID(sDirName);
            FileID = GetFileID(sFileName, FileHash);

            if (DirID < 0)
            {
                B = false;
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/setInventoryArchive 01 - Could not get the directory id for " + sDirName + ".");
                return B;
            }
            if (FileID < 0)
            {
                B = false;
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/setInventoryArchive 02 - Could not get the file id for " + sFileName + ".");
                return B;
            }

            if (ArchiveFlag)
                iArchiveFlag = 1;
            else
                iArchiveFlag = 0;

            string S = "Update Inventory set NeedsArchive = " + iArchiveFlag.ToString();
            S += " where DirID = " + DirID.ToString() + " and FileId = " + FileID.ToString();

            // Dim cn As New SQLiteConnection(GetCS)
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS("");
                CONN.Open();
            }

            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.Parameters.AddWithValue("@DirID", DirID);
                cmd.Parameters.AddWithValue("@FileID", FileID);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/setInventoryArchive 04 - " + ex.Message + Environment.NewLine + S);
                B = false;
            }
            finally
            {
                cmd.Dispose();
                // If cn IsNot Nothing Then
                // If cn.State = ConnectionState.Open Then
                // cn.Close()
                // End If
                // cn.Dispose()
                // End If
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }

            return B;
        }

        /// <summary>
        /// Sets the inventory archive.
        /// </summary>
        /// <param name="DirID">The dir identifier.</param>
        /// <param name="FileID">The file identifier.</param>
        /// <param name="ArchiveFlag">if set to <c>true</c> [archive flag].</param>
        /// <returns></returns>
        public static bool setInventoryArchive(int DirID, int FileID, bool ArchiveFlag)
        {
            bool B = true;

            int iArchiveFlag = 0;
            //int FileExist = 1;
            //int NeedsArchive = 1;
            //int UseArchiveBit = 0;

            if (ArchiveFlag)
                iArchiveFlag = 1;
            else
                iArchiveFlag = 0;

            string S = "Update Inventory set NeedsArchive = " + iArchiveFlag.ToString();
            S += " where DirID = " + DirID.ToString() + " and FileId = " + FileID.ToString();

            // Dim cn As New SQLiteConnection(GetCS)
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS("");
                CONN.Open();
            }

            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.Parameters.AddWithValue("@DirID", DirID);
                cmd.Parameters.AddWithValue("@FileID", FileID);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/setInventoryArchive 104 - " + ex.Message + Environment.NewLine + S);
                B = false;
            }
            finally
            {
                cmd.Dispose();
                // If cn IsNot Nothing Then
                // If cn.State = ConnectionState.Open Then
                // cn.Close()
                // End If
                // cn.Dispose()
                // End If
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }

            return B;
        }

        /// <summary>
        /// Cks the needs archive.
        /// </summary>
        /// <param name="FQN">The FQN.</param>
        /// <param name="SkipIfArchiveBitOn">if set to <c>true</c> [skip if archive bit on].</param>
        /// <param name="FileHash">The file hash.</param>
        /// <returns></returns>
        public static bool ckNeedsArchive(string FQN, bool SkipIfArchiveBitOn, ref string FileHash)
        {
            //int iArchiveFlag = 0;
            //int FileExist = 1;
            //int NeedsArchive = 1;
            //int UseArchiveBit = 0;
            int DirID = 0;
            int FileID = 0;
            long FileSize = 0;
            bool B = true;
            string sDirName = "";
            string sFileName = "";
            DateTime LastUpdate = default(DateTime);
            bool ArchiveBit = true;
            
            var ArchBit = ((File.GetAttributes(FQN) & FileAttributes.Archive) == FileAttributes.Archive);

            if (!ArchBit & SkipIfArchiveBitOn)
                return false;

            FileInfo FI = new FileInfo(FQN);

            try
            {
                sDirName = FI.DirectoryName;
                sFileName = FI.Name;
                FileSize = FI.Length;
                LastUpdate = FI.LastWriteTime;
            }
            catch (Exception ex)
            {
                B = false;
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/setInventoryArchive 00 - " + ex.Message);
                return B;
            }

            DirID = GetDirID(sDirName);
            FileID = GetFileID(sFileName, FileHash);

            if (DirID < 0)
            {
                B = addDir(sDirName, false);
                LOG.WriteToArchiveLog("Notice: clsDbLocal/setInventoryArchive 01 - Added directory " + sDirName + ".");
                DirID = GetDirID(sDirName);
            }
            if (FileID < 0)
            {
                B = addFile(sFileName, FileHash);
                LOG.WriteToArchiveLog("Notice: clsDbLocal/setInventoryArchive 02 - Added file " + sFileName + ".");
                FileID = GetFileID(sFileName, FileHash);
            }

            //bool bNeedsArchive = true;
            bool NeedsToBeArchived = true;
            bool FileExistsInInventory = true;

            FileExistsInInventory = InventoryExists(DirID, FileID, FileHash);

            if (!FileExistsInInventory)
            {
                addInventory(DirID, FileID, FileSize, LastUpdate, ArchiveBit, FileHash);
                NeedsToBeArchived = true;
                return NeedsToBeArchived;
            }

            string S = "Select FileSize, LastUpdate, NeedsArchive from Inventory where DirID = " + DirID.ToString() + " and FileID = " + FileID.ToString();
            // Dim cn As New SQLiteConnection(GetCS)
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS("");
                CONN.Open();
            }

            //int iCnt = 0;

            long prevFileSize = 0;
            DateTime prevLastUpdate = default(DateTime);
            bool prevNeedsArchive = false;

            try
            {
                SQLiteCommand cmd = new SQLiteCommand(S, CONN);
                cmd.CommandType = CommandType.Text;

                // ** if you don’t set the result set to scrollable HasRows does not work
                SQLiteDataReader rs = cmd.ExecuteReader();

                if (rs.HasRows)
                {
                    rs.Read();
                    prevFileSize = rs.GetInt64(0);
                    prevLastUpdate = rs.GetDateTime(1);
                    prevNeedsArchive = rs.GetBoolean(2);
                }

                if (!rs.IsClosed)
                    rs.Close();
                rs.Dispose();

                if (prevFileSize != FileSize)
                    B = true;
                else if (!prevLastUpdate.ToString().Equals(LastUpdate.ToString()))
                    B = true;
                else
                    B = false;
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/InventoryExists - " + ex.Message + Environment.NewLine + S);
                FileID = -1;
            }
            finally
            {
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();

            return B;
        }

        /// <summary>
        /// Adds the inventory.
        /// </summary>
        /// <param name="DirID">The dir identifier.</param>
        /// <param name="FileID">The file identifier.</param>
        /// <param name="FileSize">Size of the file.</param>
        /// <param name="LastUpdate">The last update.</param>
        /// <param name="ArchiveBit">if set to <c>true</c> [archive bit].</param>
        /// <param name="FileHash">The file hash.</param>
        /// <returns></returns>
        public static bool addInventory(int DirID, int FileID, long FileSize, DateTime LastUpdate, bool ArchiveBit, string FileHash)
        {
            bool FileExist = true;
            bool NeedsArchive = true;
            bool B = true;
            //int UseArchiveBit = 0;

            // Dim S As String = "Insert into Directory (DirName,UseArchiveBit) values ('" + FQN + "', " + UseArchiveBit.ToString + ") "
            string S = "Insert into Inventory (DirID,FileID,FileExist,FileSize,LastUpdate,ArchiveBit,NeedsArchive,FileHash) values ";
            S += "(@DirID, @FileID, @FileExist, @FileSize,@LastUpdate,@ArchiveBit,@NeedsArchive,@FileHash)";

            // Dim cn As New SQLiteConnection(GetCS)
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS("");
                CONN.Open();
            }

            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.Parameters.AddWithValue("@DirID", DirID);
                cmd.Parameters.AddWithValue("@FileID", FileID);
                cmd.Parameters.AddWithValue("@FileExist", FileExist);
                cmd.Parameters.AddWithValue("@FileSize", FileSize);
                cmd.Parameters.AddWithValue("@LastUpdate", LastUpdate);
                cmd.Parameters.AddWithValue("@ArchiveBit", ArchiveBit);
                cmd.Parameters.AddWithValue("@NeedsArchive", NeedsArchive);
                cmd.Parameters.AddWithValue("@FileHash", FileHash);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/addInventory - " + ex.Message + Environment.NewLine + S);
                B = false;
            }
            finally
            {
                cmd.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }

            return B;
        }

    }
}
