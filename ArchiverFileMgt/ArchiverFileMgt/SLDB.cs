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

namespace ArchiverFileMgt.app_code
{

    /// <summary>
    /// Manages the global access to the local SQL Lite DB
    /// </summary>
    public static class SLDB
    {

        static private ECMEncrypt ENC = new ECMEncrypt();

        static private SQLiteConnection CONN = new SQLiteConnection();
        static private string CS = "";

        static private string LiteDBPath = "";

        /// <summary>
        /// Initializes the database.
        /// </summary>
        public static void InitDB()
        {

            string tPath = System.IO.Path.GetTempPath();
            tPath = tPath + @"EcmLibrary\SqlLiteDB";
            LiteDBPath = tPath;

            CopyDatabases();

            if (!File.Exists(LiteDBPath + @"\EcmArchive.db"))
                Console.WriteLine("MISSING: " + LiteDBPath + @"\EcmArchive.db");

            CS = GetCS();
            CONN = CreateSQLiteConnection();

        }

        /// <summary>
        /// Gets the cs.
        /// </summary>
        /// <returns></returns>
        public static string GetCS()
        {
            return "Data Source= EcmArchive.db; Version = 3; New = True; Compress = True; ";
        }

        /// <summary>
        /// Creates the sq lite connection.
        /// </summary>
        /// <returns>A connection to the DB</returns>
        public static SQLiteConnection CreateSQLiteConnection()
        {
            SQLiteConnection sqlite_conn;
            // Create a new database connection:
            sqlite_conn = new SQLiteConnection(GetCS());
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
        /// Finds the sql lite database.
        /// </summary>
        /// <param name="DirName">Name of the dir.</param>
        /// <param name="IncludeSubDir">if set to <c>true</c> [include sub dir].</param>
        /// <returns>path to the specified DB</returns>
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

                        }
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
        /// Finds the ce database.
        /// </summary>
        /// <param name="NewPath">The new path.</param>
        /// <returns>PAth to the CE database</returns>
        public static string FindCeDatabase(string NewPath)
        {
            string S = "";

            List<string> listOfFiles = new List<string>();
            listOfFiles = findSQLiteDB(NewPath, true);

            string NewCE = "";
            foreach (string fName in listOfFiles)
            {
                NewCE = NewPath + @"\" + "EcmArchive.db";
                if (!File.Exists(NewCE))
                {
                    File.Copy(fName, NewCE);
                    S = NewCE;
                    break;
                }
            }

            return S;
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
        /// Gets the dir identifier.
        /// </summary>
        /// <param name="DirName">Name of the dir.</param>
        /// <returns>DIR ID</returns>
        public static int GetDirID(string DirName)
        {
            DirName = DirName.Replace("'", "''");
            int DirID = -1;
            string S = "Select DirID from Directory where DirName = '" + DirName + "' ";
            // Dim cn As New SQLiteConnection(GetCS())

            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
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
        /// <returns>Directory NAME</returns>
        public static int GetDirID(string DirName, ref bool UseArchiveBit)
        {
            UseArchiveBit = false;
            int DirID = -1;
            string S = "Select DirID,UseArchiveBit from Directory where DirName = '" + DirName + "' ";
            // Dim cn As New SQLiteConnection(GetCS())

            try
            {

                if (CONN.State == ConnectionState.Closed)
                {
                    CONN.ConnectionString = GetCS();
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
                CONN.ConnectionString = GetCS();
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
        /// Deletes the dir.
        /// </summary>
        /// <param name="DirName">Name of the dir.</param>
        /// <returns></returns>
        public static bool delDir(string DirName)
        {
            bool B = true;
            string S = "Delete from Directory where DirName = @DirName ";

            // Dim cn As New SQLiteConnection(GetCS())
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }

            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.Parameters.AddWithValue("@DirName", DirName);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/delDir - " + ex.Message + Environment.NewLine + S);
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
        /// Gets the file identifier by File Hash code
        /// </summary>
        /// <param name="FileName">Name of the file.</param>
        /// <param name="FileHash">The file hash.</param>
        /// <returns></returns>
        public static int GetFileID(string FileName, string FileHash)
        {
            FileName = FileName.Replace("'", "''");
            int FileID = -1;
            string S = "Select FileID from Files where FileName = '" + FileName + "' and Filehash = '" + FileHash + "' ";

            // Dim cn As New SQLiteConnection(GetCS())

            try
            {
                if (CONN.State == ConnectionState.Closed)
                {
                    CONN.ConnectionString = GetCS();
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
                CONN.ConnectionString = GetCS();
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
                CONN.ConnectionString = GetCS();
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
        /// cChecks if a File the exists in the local DB.
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
                CONN.ConnectionString = GetCS();
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
        /// Checks if Contact exists.
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
                CONN.ConnectionString = GetCS();
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
        /// Deletes the file.
        /// </summary>
        /// <param name="FileName">Name of the file.</param>
        /// <returns></returns>
        public static bool delFile(string FileName)
        {
            bool B = true;
            string S = "Delete from Files where FileName = @FileName ";

            // Dim cn As New SQLiteConnection(GetCS())
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }
            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.Parameters.AddWithValue("@DirName", FileName);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/delFile - " + ex.Message + Environment.NewLine + S);
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
        /// Adds the inventory by force.
        /// </summary>
        /// <param name="FQN">The FQN.</param>
        /// <param name="bArchiveBit">if set to <c>true</c> [b archive bit].</param>
        /// <returns></returns>
        public static bool addInventoryForce(string FQN, bool bArchiveBit)
        {
            //int iArchiveFlag = 0;
            int FileExist = 1;
            int NeedsArchive = 1;
            //int UseArchiveBit = 0;
            int DirID = 0;
            int FileID = 0;
            long FileSize = 0;
            bool B = true;
            FileInfo FI = new FileInfo(FQN);
            string sDirName = "";
            string sFileName = "";
            DateTime LastUpdate = default(DateTime);
            int ArchiveBit = 1;
            string FileHash = "";

            if (bArchiveBit)
                ArchiveBit = 1;
            else
                ArchiveBit = 0;

            FQN = FQN.Replace("''", "'");
            FileHash = ENC.hashSha1File(FQN);
            sFileName = sFileName.Replace("''", "'");
            sDirName = sDirName.Replace("''", "'");
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
            sFileName = sFileName.Replace("''", "'");
            sDirName = sDirName.Replace("''", "'");

            DirID = GetDirID(sDirName);
            FileID = GetFileID(sFileName, FileHash);

            if (DirID < 0)
            {
                B = addDir(sDirName, false);
                LOG.WriteToArchiveLog("NOTICE: clsDbLocal/setInventoryArchive 01 - Added directory " + sDirName + ".");
                DirID = GetDirID(sDirName);
            }
            if (FileID < 0)
            {
                B = addFile(sFileName, FileHash);
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/setInventoryArchive 02 - Added file " + sFileName + ".");
                FileID = GetFileID(sFileName, FileHash);
            }

            if (InventoryExists(DirID, FileID, FileHash))
                return true;

            // Dim S As String = "Insert into Directory (DirName,UseArchiveBit) values ('" + FQN + "', " + UseArchiveBit.ToString + ") "
            string S = "Insert into Inventory (DirID,FileID,FileExist,FileSize,LastUpdate,ArchiveBit,NeedsArchive,FileHash) values ";
            S += "(@DirID, @FileID, @FileExist, @FileSize,@LastUpdate,@ArchiveBit,@NeedsArchive,@FileHash)";

            // Dim cn As New SQLiteConnection(GetCS)
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
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
                CONN.ConnectionString = GetCS();
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

        /// <summary>
        /// Deletes the inventory.
        /// </summary>
        /// <param name="DirID">The dir identifier.</param>
        /// <param name="FileID">The file identifier.</param>
        /// <returns></returns>
        public static bool delInventory(int DirID, int FileID)
        {
            bool B = true;

            string S = "delete from Inventory where DirID = " + DirID.ToString() + " and FileID = " + FileID.ToString();

            // Dim cn As New SQLiteConnection(GetCS)
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
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
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/delInventory - " + ex.Message + Environment.NewLine + S);
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
        /// Checks if Inventoried file the exists.
        /// </summary>
        /// <param name="DirID">The dir identifier.</param>
        /// <param name="FileID">The file identifier.</param>
        /// <param name="CRC">The CRC.</param>
        /// <returns>File Hash code</returns>
        public static bool InventoryExists(int DirID, int FileID, string CRC)
        {
            bool B = false;
            string S = "Select FileHash from Inventory where DirID = " + DirID.ToString() + " and FileID = " + FileID.ToString();
            // Dim cn As New SQLiteConnection(GetCS)
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
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
        /// Compares Inventory file hash.
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
                CONN.ConnectionString = GetCS();
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
                CONN.ConnectionString = GetCS();
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
                CONN.ConnectionString = GetCS();
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

            if (FileHash.Length == 0)
                FileHash = ENC.getSha1HashFromFile(FQN);

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
                CONN.ConnectionString = GetCS();
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
        /// Truncates the dirs.
        /// </summary>
        public static void truncateDirs()
        {
            string S = "delete from Directory";

            // Dim cn As New SQLiteConnection(GetCS())
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }

            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/truncateDirs 104 - " + ex.Message + Environment.NewLine + S);
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
        }

        /// <summary>
        /// Truncates the contacts.
        /// </summary>
        public static void truncateContacts()
        {
            string S = "delete from ContactsArchive";

            // Dim cn As New SQLiteConnection(GetCS())
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }

            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/truncateContacts 104 - " + ex.Message + Environment.NewLine + S);
            }
            finally
            {
                cmd.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }
        }

        /// <summary>
        /// Truncates the exchange.
        /// </summary>
        public static void truncateExchange()
        {
            string S = "delete from Exchange";

            // Dim cn As New SQLiteConnection(GetCS())
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }

            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/truncateExchange 104 - " + ex.Message + Environment.NewLine + S);
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
        }

        /// <summary>
        /// Truncates the outlook.
        /// </summary>
        public static void truncateOutlook()
        {
            string S = "delete from Outlook";

            // Dim cn As New SQLiteConnection(GetCS())
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }

            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/truncateOutlook 104 - " + ex.Message + Environment.NewLine + S);
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
        }

        /// <summary>
        /// Truncates the files.
        /// </summary>
        public static void truncateFiles()
        {
            string S = "delete from Files";

            // Dim cn As New SQLiteConnection(GetCS())
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }

            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/truncateFiles 104 - " + ex.Message + Environment.NewLine + S);
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
        }

        /// <summary>
        /// Truncates the inventory.
        /// </summary>
        public static void truncateInventory()
        {
            string S = "delete from Inventory";

            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }

            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/truncateInventory 104 - " + ex.Message + Environment.NewLine + S);
            }
            finally
            {
                cmd.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }
        }

        /// <summary>
        /// Backups the dir table.
        /// </summary>
        public static void BackupDirTbl()
        {
            string Dirname = null;
            int DirID = default(int);
            bool UseArchiveBit = default(Boolean);

            SQLiteConnection TempConn = new SQLiteConnection();
            TempConn.ConnectionString = GetCS();
            TempConn.Open();

            string S = "Select Dirname,DirID,UseArchiveBit from Directory";

            string tPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
            string SavePath = tPath + @"\ECM\QuickRefData";
            string SaveFQN = SavePath + @"\Directory.dat";

            if (!Directory.Exists(SavePath))
                Directory.CreateDirectory(SavePath);

            StreamWriter fOut = new StreamWriter(SaveFQN, false);
            //string msg = "";

            try
            {
                SQLiteCommand cmd = new SQLiteCommand(S, TempConn);
                cmd.CommandType = CommandType.Text;

                // ** if you don’t set the result set to scrollable HasRows does not work
                SQLiteDataReader rs = cmd.ExecuteReader();

                if (rs.HasRows)
                {
                    while (rs.Read())
                    {
                        Dirname = rs.GetString(0);
                        DirID = rs.GetInt32(1);
                        UseArchiveBit = rs.GetBoolean(2);

                        fOut.WriteLine(Dirname + "|" + DirID.ToString() + "|" + UseArchiveBit.ToString());
                    }
                }

                if (!rs.IsClosed)
                    rs.Close();
                rs.Dispose();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/BackupDirTbl - " + ex.Message + Environment.NewLine + S);
            }
            finally
            {
                fOut.Close();
                fOut.Dispose();
                if (TempConn != null)
                {
                    if (TempConn.State == ConnectionState.Open)
                        TempConn.Close();
                    TempConn.Dispose();
                }
            }
            GC.Collect();
            GC.WaitForPendingFinalizers();
        }

        /// <summary>
        /// Restoreps the dir table.
        /// </summary>
        public static void RestorepDirTbl()
        {
            string Dirname = null;
            int DirID = default(int);
            bool UseArchiveBit = default(Boolean);

            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }

            string tPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
            string SavePath = tPath + @"\ECM\QuickRefData";
            string SaveFQN = SavePath + @"\Directory.dat";

            if (!Directory.Exists(SavePath))
            {
                LOG.WriteToArchiveLog("NOTICE:RestorepDirTbl Restore directory " + SaveFQN + " does not exist, returning.");
                return;
            }

            StreamReader fOut = new StreamReader(SaveFQN);
            string inStr = "";
            string[] A = null;

            SQLiteCommand cmd = new SQLiteCommand();
            cmd.CommandText = "SET IDENTITY_INSERT Directory ON";
            cmd.ExecuteNonQuery();

            cmd.CommandText = "delete form Directory";
            cmd.ExecuteNonQuery();

            try
            {
                cmd.Connection = CONN;
                cmd.CommandType = CommandType.Text;

                while (inStr == fOut.ReadLine())
                {
                    A = inStr.Split('|');
                    Dirname = A[0];
                    DirID = System.Convert.ToInt32(A[1]);
                    UseArchiveBit = System.Convert.ToBoolean(A[2]);

                    try
                    {
                        cmd.CommandText = "Insert into Directory (DirName, DirID, UseArchiveBit) values (@DirName, @DirID, @UseArchiveBit)";
                        cmd.Parameters.AddWithValue("@DirName", Dirname);
                        cmd.Parameters.AddWithValue("@DirID", DirID);
                        cmd.Parameters.AddWithValue("@UseArchiveBit", UseArchiveBit);
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        LOG.WriteToArchiveLog("ERROR:RestorepDirTbl Failed insert: " + inStr);
                        LOG.WriteToArchiveLog("ERROR:RestorepDirTbl : " + ex.Message);
                    }
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/RestorepDirTbl - " + ex.Message);
            }
            finally
            {
                cmd.CommandText = "SET IDENTITY_INSERT Directory OFF";
                cmd.ExecuteNonQuery();
                cmd.Dispose();
                fOut.Close();
                fOut.Dispose();
            }
            GC.Collect();
            GC.WaitForPendingFinalizers();
        }

        /// <summary>
        /// Backups the file table.
        /// </summary>
        public static void BackupFileTbl()
        {
            string Filename = null;
            int FileID = default(int);

            string S = "Select Filename,FileID from Files";

            SQLiteConnection TempConn = new SQLiteConnection();
            TempConn.ConnectionString = GetCS();
            TempConn.Open();

            string tPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
            string SavePath = tPath + @"\ECM\QuickRefData";
            string SaveFQN = SavePath + @"\Files.dat";

            if (!Directory.Exists(SavePath))
                Directory.CreateDirectory(SavePath);

            StreamWriter fOut = new StreamWriter(SaveFQN, false);
            //string msg = "";

            try
            {
                SQLiteCommand cmd = new SQLiteCommand(S, TempConn);
                cmd.CommandType = CommandType.Text;

                // ** if you don’t set the result set to scrollable HasRows does not work
                SQLiteDataReader rs = cmd.ExecuteReader();

                if (rs.HasRows)
                {
                    while (rs.Read())
                    {
                        Filename = rs.GetString(0);
                        FileID = rs.GetInt32(1);
                        fOut.WriteLine(Filename + "|" + FileID.ToString());
                    }
                }

                if (!rs.IsClosed)
                    rs.Close();
                rs.Dispose();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/BackupFileTbl - " + ex.Message + Environment.NewLine + S);
            }
            finally
            {
                fOut.Close();
                fOut.Dispose();
                if (TempConn != null)
                {
                    if (TempConn.State == ConnectionState.Open)
                        TempConn.Close();
                    TempConn.Dispose();
                }
            }
            GC.Collect();
            GC.WaitForPendingFinalizers();
        }

        /// <summary>
        /// Restoreps the file table.
        /// </summary>
        public static void RestorepFileTbl()
        {
            string Filename = null;
            int FileID = default(int);

            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }

            string tPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
            string SavePath = tPath + @"\ECM\QuickRefData";
            string SaveFQN = SavePath + @"\File.dat";

            if (!Directory.Exists(SavePath))
            {
                LOG.WriteToArchiveLog("NOTICE:RestorepFileTbl Restore file " + SaveFQN + " does not exist, returning.");
                return;
            }

            StreamReader fOut = new StreamReader(SaveFQN);
            string inStr = "";
            string[] A = null;

            SQLiteCommand cmd = new SQLiteCommand();
            cmd.CommandText = "SET IDENTITY_INSERT Files ON";
            cmd.ExecuteNonQuery();

            cmd.CommandText = "delete from Files";
            cmd.ExecuteNonQuery();

            try
            {
                cmd.Connection = CONN;
                cmd.CommandType = CommandType.Text;

                while (inStr == fOut.ReadLine())
                {
                    A = inStr.Split('|');
                    Filename = A[0];
                    FileID = System.Convert.ToInt32(A[1]);

                    try
                    {
                        cmd.CommandText = "Insert into Files (FileName, FileID) values (@FileName, @FileID)";
                        cmd.Parameters.AddWithValue("@Filename", Filename);
                        cmd.Parameters.AddWithValue("@FileID", FileID);
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        LOG.WriteToArchiveLog("ERROR:RestorepFileTbl Failed insert: " + inStr);
                        LOG.WriteToArchiveLog("ERROR:RestorepFileTbl : " + ex.Message);
                    }
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/RestorepFileTbl - " + ex.Message);
            }
            finally
            {
                cmd.CommandText = "SET IDENTITY_INSERT Files OFF";
                cmd.ExecuteNonQuery();
                cmd.Dispose();

                fOut.Close();
                fOut.Dispose();
            }
            GC.Collect();
            GC.WaitForPendingFinalizers();
        }

        /// <summary>
        /// Backups the inventory table.
        /// </summary>
        public static void BackupInventoryTbl()
        {
            int DirID = default(int);
            int FileID = default(int);
            int InvID = default(int);
            bool FileExist = default(Boolean);
            long Filesize = default(long);
            DateTime LastUpdate = default(DateTime);
            bool ArchiveBit = default(Boolean);
            bool NeedsArchive = default(Boolean);
            string FileHash = null;

            string S = "Select DirID,FileID,InvID,FileExist,Filesize,LastUpdate,ArchiveBit,NeedsArchive,FileHash from Inventory";

            SQLiteConnection TempConn = new SQLiteConnection();
            TempConn.ConnectionString = GetCS();
            TempConn.Open();

            string tPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
            string SavePath = tPath + @"\ECM\QuickRefData";
            string SaveFQN = SavePath + @"\Inventory.dat";

            if (!Directory.Exists(SavePath))
                Directory.CreateDirectory(SavePath);

            StreamWriter fOut = new StreamWriter(SaveFQN, false);
            //string msg = "";

            try
            {
                SQLiteCommand cmd = new SQLiteCommand(S, TempConn);
                cmd.CommandType = CommandType.Text;

                // ** if you don’t set the result set to scrollable HasRows does not work
                SQLiteDataReader rs = cmd.ExecuteReader();

                if (rs.HasRows)
                {
                    while (rs.Read())
                    {
                        DirID = rs.GetInt32(0);
                        FileID = rs.GetInt32(1);
                        InvID = rs.GetInt32(2);
                        FileExist = rs.GetBoolean(3);
                        Filesize = rs.GetInt64(4);
                        LastUpdate = rs.GetDateTime(5);
                        ArchiveBit = rs.GetBoolean(6);
                        NeedsArchive = rs.GetBoolean(7);
                        FileHash = rs.GetString(8);

                        fOut.WriteLine(DirID.ToString() + "|" + FileID.ToString() + "|" + InvID.ToString() + "|" + FileExist.ToString() + "|" + LastUpdate.ToString() + "|" + ArchiveBit.ToString() + "|" + NeedsArchive.ToString() + "|" + FileHash.ToString());
                    }
                }

                if (!rs.IsClosed)
                    rs.Close();
                rs.Dispose();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/BackupFileTbl - " + ex.Message + Environment.NewLine + S);
            }
            finally
            {
                fOut.Close();
                fOut.Dispose();
                if (TempConn != null)
                {
                    if (TempConn.State == ConnectionState.Open)
                        TempConn.Close();
                    TempConn.Dispose();
                }
            }
            GC.Collect();
            GC.WaitForPendingFinalizers();
        }

        /// <summary>
        /// Restoreps the inventory table.
        /// </summary>
        public static void RestorepInventoryTbl()
        {

            // SET IDENTITY_INSERT dbo.Tool ON

            int DirID = default(int);
            int FileID = default(int);
            int InvID = default(int);
            bool FileExist = default(Boolean);
            long FileSize = default(long);
            DateTime LastUpdate = default(DateTime);
            bool ArchiveBit = default(Boolean);
            bool NeedsArchive = default(Boolean);
            string FileHash = null;

            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }

            string tPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
            string SavePath = tPath + @"\ECM\QuickRefData";
            string SaveFQN = SavePath + @"\Inventory.dat";

            if (!Directory.Exists(SavePath))
            {
                LOG.WriteToArchiveLog("NOTICE:RestorepInventoryTbl Restore file " + SaveFQN + " does not exist, returning.");
                return;
            }

            StreamReader fOut = new StreamReader(SaveFQN);
            string inStr = "";
            string[] A = null;
            SQLiteCommand cmd = new SQLiteCommand();

            try
            {
                cmd.Connection = CONN;
                cmd.CommandType = CommandType.Text;

                cmd.CommandText = "SET IDENTITY_INSERT Inventory ON";
                cmd.ExecuteNonQuery();

                cmd.CommandText = "delete from Inventory";
                cmd.ExecuteNonQuery();

                while (inStr == fOut.ReadLine())
                {
                    A = inStr.Split('|');

                    DirID = System.Convert.ToInt32(A[0]);
                    FileID = System.Convert.ToInt32(A[1]);
                    InvID = System.Convert.ToInt32(A[2]);
                    FileExist = System.Convert.ToBoolean(A[3]);
                    FileSize = System.Convert.ToInt64(A[4]);
                    LastUpdate = Convert.ToDateTime(A[5]);
                    ArchiveBit = System.Convert.ToBoolean(A[6]);
                    NeedsArchive = System.Convert.ToBoolean(A[7]);
                    FileHash = A[0];

                    try
                    {
                        cmd.CommandText = "Insert into Files (FileName, FileID) values (@FileName, @FileID)";
                        cmd.Parameters.AddWithValue("@DirID", DirID);
                        cmd.Parameters.AddWithValue("@FileID", FileID);
                        cmd.Parameters.AddWithValue("@InvID", InvID);
                        cmd.Parameters.AddWithValue("@FileExist", FileExist);
                        cmd.Parameters.AddWithValue("@LastUpdate", LastUpdate);
                        cmd.Parameters.AddWithValue("@ArchiveBit", ArchiveBit);
                        cmd.Parameters.AddWithValue("@NeedsArchive", NeedsArchive);
                        cmd.Parameters.AddWithValue("@FileHash", FileHash);
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        LOG.WriteToArchiveLog("ERROR:RestorepInventoryTbl Failed insert: " + inStr);
                        LOG.WriteToArchiveLog("ERROR:RestorepInventoryTbl : " + ex.Message);
                    }
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/RestorepInventoryTbl - " + ex.Message);
            }
            finally
            {
                cmd.CommandText = "SET IDENTITY_INSERT Inventory OFF";
                cmd.ExecuteNonQuery();
                cmd.Dispose();
                fOut.Close();
                fOut.Dispose();
            }
            GC.Collect();
            GC.WaitForPendingFinalizers();
        }

        /// <summary>
        /// Backups the outlook table.
        /// </summary>
        public static void BackupOutlookTbl()
        {
            string sKey = null;
            int RowID = default(int);

            string S = "Select sKey,RowID from Outlook";

            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }

            string tPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
            string SavePath = tPath + @"\ECM\QuickRefData";
            string SaveFQN = SavePath + @"\Outlook.dat";

            if (!Directory.Exists(SavePath))
                Directory.CreateDirectory(SavePath);

            StreamWriter fOut = new StreamWriter(SaveFQN, false);
            //string msg = "";

            try
            {
                SQLiteCommand cmd = new SQLiteCommand(S, CONN);
                cmd.CommandType = CommandType.Text;

                // ** if you don’t set the result set to scrollable HasRows does not work
                SQLiteDataReader rs = cmd.ExecuteReader();

                if (rs.HasRows)
                {
                    while (rs.Read())
                    {
                        sKey = rs.GetString(0);
                        RowID = rs.GetInt32(1);
                        fOut.WriteLine(sKey + "|" + RowID.ToString());
                    }
                }

                if (!rs.IsClosed)
                    rs.Close();
                rs.Dispose();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/BackupOutlookTbl - " + ex.Message + Environment.NewLine + S);
            }
            finally
            {
                fOut.Close();
                fOut.Dispose();
                if (CONN != null)
                {
                    if (CONN.State == ConnectionState.Open)
                        CONN.Close();
                    CONN.Dispose();
                }
            }
            GC.Collect();
            GC.WaitForPendingFinalizers();
        }

        /// <summary>
        /// Backups the exchange table.
        /// </summary>
        public static void BackupExchangeTbl()
        {
            string sKey = null;
            int RowID = default(int);

            string S = "Select sKey,RowID from Exchange";

            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }

            string tPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
            string SavePath = tPath + @"\ECM\QuickRefData";
            string SaveFQN = SavePath + @"\Exchange.dat";

            if (!Directory.Exists(SavePath))
                Directory.CreateDirectory(SavePath);

            StreamWriter fOut = new StreamWriter(SaveFQN, false);
            //string msg = "";

            try
            {
                SQLiteCommand cmd = new SQLiteCommand(S, CONN);
                cmd.CommandType = CommandType.Text;

                // ** if you don’t set the result set to scrollable HasRows does not work
                SQLiteDataReader rs = cmd.ExecuteReader();

                if (rs.HasRows)
                {
                    while (rs.Read())
                    {
                        sKey = rs.GetString(0);
                        RowID = rs.GetInt32(1);
                        fOut.WriteLine(sKey + "|" + RowID.ToString());
                    }
                }

                if (!rs.IsClosed)
                    rs.Close();
                rs.Dispose();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/BackupOutlookTbl - " + ex.Message + Environment.NewLine + S);
            }
            finally
            {
                fOut.Close();
                fOut.Dispose();
                if (CONN != null)
                {
                    if (CONN.State == ConnectionState.Open)
                        CONN.Close();
                    CONN.Dispose();
                }
            }
            GC.Collect();
            GC.WaitForPendingFinalizers();
        }

        /// <summary>
        /// Adds the outlook.
        /// </summary>
        /// <param name="sKey">The s key.</param>
        /// <returns></returns>
        public static bool addOutlook(string sKey)
        {
            bool B = false;
            //int UseArchiveBit = 0;

            B = OutlookExists(sKey);
            if (B)
                return true;

            string S = "Insert into Outlook (sKey) values (@sKey) ";
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }

            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.Parameters.AddWithValue("@sKey", sKey);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/addOutlook - " + ex.Message + Environment.NewLine + S);
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
        /// Adds the exchange.
        /// </summary>
        /// <param name="sKey">The s key.</param>
        /// <returns></returns>
        public static bool addExchange(string sKey)
        {
            bool B = true;
            //int UseArchiveBit = 0;

            string S = "Insert into Exchange (sKey) values (@sKey) ";
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }

            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.Parameters.AddWithValue("@sKey", sKey);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/addExchange - " + ex.Message + Environment.NewLine + S);
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
        /// Outlooks the exists.
        /// </summary>
        /// <param name="sKey">The s key.</param>
        /// <returns></returns>
        public static bool OutlookExists(string sKey)
        {
            bool B = false;
            string S = "Select count(*) from Outlook where sKey = '" + sKey + "'";
            // Dim cn As New SQLiteConnection(GetCS)
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
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
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/OutlookExists - " + ex.Message + Environment.NewLine + S);
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
        /// Exchanges the exists.
        /// </summary>
        /// <param name="sKey">The s key.</param>
        /// <returns></returns>
        public static bool ExchangeExists(string sKey)
        {
            bool B = false;
            string S = "Select count(*) from Exchange where sKey = '" + sKey + "'";
            // Dim cn As New SQLiteConnection(GetCS)
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
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
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/OutlookExists - " + ex.Message + Environment.NewLine + S);
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
        /// Marks the exchange found.
        /// </summary>
        /// <param name="sKey">The s key.</param>
        /// <returns></returns>
        public static bool MarkExchangeFound(string sKey)
        {
            bool B = true;
            string S = "Update exchange set KeyExists = @B where sKey = @sKey ";

            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }
            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.Parameters.AddWithValue("@B", true);
                cmd.Parameters.AddWithValue("@sKey", sKey);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/MarkExchangeFound - " + ex.Message + Environment.NewLine + S);
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
        /// Marks the outlook found.
        /// </summary>
        /// <param name="sKey">The s key.</param>
        /// <returns></returns>
        public static bool MarkOutlookFound(string sKey)
        {
            bool B = true;
            string S = "Update Outlook set KeyExists = @B where sKey = @sKey ";

            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }
            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.Parameters.AddWithValue("@B", true);
                cmd.Parameters.AddWithValue("@sKey", sKey);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/MarkOutlookFound - " + ex.Message + Environment.NewLine + S);
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
        /// Deletes the outlook.
        /// </summary>
        /// <param name="sKey">The s key.</param>
        /// <returns></returns>
        public static bool delOutlook(string sKey)
        {
            bool B = true;
            string S = "Delete from Outlook where sKey = @sKey ";

            // Dim cn As New SQLiteConnection(GetCS())
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }
            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.Parameters.AddWithValue("@sKey", sKey);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/delOutlook - " + ex.Message + Environment.NewLine + S);
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
        /// Deletes the exchange.
        /// </summary>
        /// <param name="sKey">The s key.</param>
        /// <returns></returns>
        public static bool delExchange(string sKey)
        {
            bool B = true;
            string S = "Delete from Exchange where sKey = @sKey ";

            // Dim cn As New SQLiteConnection(GetCS())
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }
            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.Parameters.AddWithValue("@sKey", sKey);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/delExchange - " + ex.Message + Environment.NewLine + S);
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
        /// Deletes the outlook missing.
        /// </summary>
        /// <param name="sKey">The s key.</param>
        /// <returns></returns>
        public static bool delOutlookMissing(string sKey)
        {
            bool B = true;
            string S = "Delete from Outlook where not keyExists  ";

            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }
            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/delOutlookMissing - " + ex.Message + Environment.NewLine + S);
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
        /// Deletes the exchange missing.
        /// </summary>
        /// <param name="sKey">The s key.</param>
        /// <returns></returns>
        public static bool delExchangeMissing(string sKey)
        {
            bool B = true;
            string S = "Delete from Exchange where not keyExists  ";

            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }
            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/delExchangeMissing - " + ex.Message + Environment.NewLine + S);
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
        /// Sets the outlook missing.
        /// </summary>
        /// <returns></returns>
        public static bool setOutlookMissing()
        {
            bool B = true;
            string S = "Update Outlook set keyExists = 0 ";

            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }
            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/setOutlookMissing - " + ex.Message + Environment.NewLine + S);
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
        /// Sets the exchange missing.
        /// </summary>
        /// <param name="sKey">The s key.</param>
        /// <returns></returns>
        public static bool setExchangeMissing(string sKey)
        {
            bool B = true;
            string S = "Update Exchange set KeyExists = false ";

            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }
            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/setExchangeMissing - " + ex.Message + Environment.NewLine + S);
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
        /// Sets the outlook key found.
        /// </summary>
        /// <param name="sKey">The s key.</param>
        /// <returns></returns>
        public static bool setOutlookKeyFound(string sKey)
        {
            if (sKey.Length > 500)
                sKey = sKey.Substring(0, 499);

            bool B = true;
            string S = "Udpate Outlook set keyExists = true where sKey = @sKey  ";

            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }
            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.Parameters.AddWithValue("@sKey", sKey);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("WARNING: clsDbLocal/setOutlookKeyFound - " + ex.Message + Environment.NewLine + S);
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
        /// Sets the exchange key found.
        /// </summary>
        /// <param name="sKey">The s key.</param>
        /// <returns></returns>
        public static bool setExchangeKeyFound(string sKey)
        {
            bool B = true;
            string S = "Udpate Exchange set keyExists = true where sKey = @sKey  ";

            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }
            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.Parameters.AddWithValue("@sKey", sKey);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/setExchangeKeyFound - " + ex.Message + Environment.NewLine + S);
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
        /// Loads the exchange keys.
        /// </summary>
        /// <param name="L">The l.</param>
        public static void LoadExchangeKeys(ref SortedList<string, string> L)
        {
            string S = "Select sKey from Exchange";
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }

            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            string sKey = "";

            try
            {
                cmd.CommandType = CommandType.Text;

                // ** if you don’t set the result set to scrollable HasRows does not work
                SQLiteDataReader rs = cmd.ExecuteReader();
                int iKey = 0;
                if (rs.HasRows)
                {
                    while (rs.Read())
                    {
                        sKey = rs.GetString(0);
                        if (L.IndexOfKey(sKey) < 0)
                        {
                            try
                            {
                                L.Add(sKey, iKey.ToString());
                            }
                            catch (Exception ex2)
                            {
                                Console.WriteLine(ex2.Message);
                            }
                        }
                        iKey += 1;
                    }
                }

                if (!rs.IsClosed)
                    rs.Close();
                rs.Dispose();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/BackupDirTbl - " + ex.Message + Environment.NewLine + S);
            }
            finally
            {
            }
            GC.Collect();
            GC.WaitForPendingFinalizers();
        }

        /// <summary>
        /// Adds the listener.
        /// </summary>
        /// <param name="FQN">The FQN.</param>
        /// <returns></returns>
        public static bool addListener(string FQN)
        {
            bool B = true;
            string S = "Insert into Listener (FQN) values (@FQN) ";
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }

            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.Parameters.AddWithValue("@FQN", FQN);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/addListener - " + ex.Message + Environment.NewLine + S);
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
        /// Deletes the listeners processed.
        /// </summary>
        /// <returns></returns>
        public static bool DelListenersProcessed()
        {
            bool B = true;
            string S = "delete from Listener where Uploaded = 1";
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }

            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                // cmd.Parameters.AddWithValue("@FQN", FQN)
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/addListener - " + ex.Message + Environment.NewLine + S);
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
        /// Marks the listeners processed.
        /// </summary>
        /// <param name="FQN">The FQN.</param>
        /// <returns></returns>
        public static bool MarkListenersProcessed(string FQN)
        {
            bool B = true;
            string S = "Update Listener set Uploaded = 1 where FQN = @FQN";
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }

            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.Parameters.AddWithValue("@FQN", FQN);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/addListener - " + ex.Message + Environment.NewLine + S);
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
        /// Removes the listener file.
        /// </summary>
        /// <param name="FQN">The FQN.</param>
        /// <returns></returns>
        public static bool removeListenerFile(string FQN)
        {
            bool B = true;
            string S = "Delete from Listener where FQN = @FQN";
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }

            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.Parameters.AddWithValue("@FQN", FQN);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/addListener - " + ex.Message + Environment.NewLine + S);
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
        /// Gets the listener files.
        /// </summary>
        /// <param name="L">The l.</param>
        public static void getListenerFiles(ref SortedList<string, int> L)
        {
            string FQN = null;
            SQLiteConnection CONN = new SQLiteConnection();
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }

            string S = "Select FQN from Listener";

            try
            {
                SQLiteCommand cmd = new SQLiteCommand(S, CONN);
                // ** if you don’t set the result set to scrollable HasRows does not work
                SQLiteDataReader rs = cmd.ExecuteReader();

                if (rs.HasRows)
                {
                    while (rs.Read())
                    {
                        FQN = rs.GetString(0);
                        if (L.ContainsKey(FQN))
                        {
                        }
                        else
                            L.Add(FQN, L.Count);
                    }
                }

                if (!rs.IsClosed)
                    rs.Close();
                rs.Dispose();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/getListenerFiles - " + ex.Message + Environment.NewLine + S);
            }
            finally
            {
            }
            GC.Collect();
            GC.WaitForPendingFinalizers();
        }

        /// <summary>
        /// Actives the listener files.
        /// </summary>
        /// <returns></returns>
        public static bool ActiveListenerFiles()
        {
            bool B = false;
            string S = "Select count(*) from Listener ";
            // Dim cn As New SQLiteConnection(GetCS)
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }

            int iCnt = 0;
            try
            {
                SQLiteCommand cmd = new SQLiteCommand(S, CONN);
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
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/ActiveListenerFiles - " + ex.Message + Environment.NewLine + S);
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
        /// Adds the zip file.
        /// </summary>
        /// <param name="FileName">Name of the file.</param>
        /// <param name="ParentGuid">The parent unique identifier.</param>
        /// <param name="bThisIsAnEmail">if set to <c>true</c> [b this is an email].</param>
        /// <returns></returns>
        public static bool addZipFile(string FileName, string ParentGuid, bool bThisIsAnEmail)
        {
            int EmailAttachment = 0;
            bool B = true;
            //int UseArchiveBit = 0;
            double fSize = 0;

            if (bThisIsAnEmail)
                EmailAttachment = 1;

            FileInfo FI = new FileInfo(FileName);
            fSize = FI.Length;
            FI = null;

            string S = "";
            S = S + "Insert into ZipFile (FQN, fSize, EmailAttachment) values (@FileName, @fSize, @EmailAttachment) ";

            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }

            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.Parameters.AddWithValue("@FileName", FileName);
                cmd.Parameters.AddWithValue("@fSize", fSize);
                cmd.Parameters.AddWithValue("@ParentGuid", ParentGuid);
                cmd.Parameters.AddWithValue("@EmailAttachment", EmailAttachment);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                if (ex.Message.Contains("duplicate value cannot") == true)
                {
                }
                else
                    LOG.WriteToArchiveLog("ERROR: clsDbLocal/addFile - " + ex.Message + Environment.NewLine + S);
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
        /// Sets the zip file processed.
        /// </summary>
        /// <param name="FileName">Name of the file.</param>
        /// <returns></returns>
        public static bool setZipFileProcessed(string FileName)
        {
            bool B = true;
            //int UseArchiveBit = 0;
            double fSize = 0;

            FileInfo FI = new FileInfo(FileName);
            fSize = FI.Length;
            FI = null;

            string S = "Update ZipFile set SuccessfullyProcessed = 1 where FQN = @FileName) ";

            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }

            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.Parameters.AddWithValue("@FileName", FileName);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/setZipFileProcessed - " + ex.Message + Environment.NewLine + S);
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
        /// Sets the zip NBR of files.
        /// </summary>
        /// <param name="FileName">Name of the file.</param>
        /// <param name="NumberOfZipFiles">The number of zip files.</param>
        /// <returns></returns>
        public static bool setZipNbrOfFiles(string FileName, int NumberOfZipFiles)
        {
            bool B = true;
            //int UseArchiveBit = 0;
            //double fSize = 0;

            string S = "Update ZipFile set NumberOfZipFiles = " + NumberOfZipFiles.ToString() + " where FQN = @FileName) ";

            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }

            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.Parameters.AddWithValue("@FileName", FileName);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/setZipNbrOfFiles - " + ex.Message + Environment.NewLine + S);
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
        /// Sets the zip in work.
        /// </summary>
        /// <param name="FileName">Name of the file.</param>
        /// <param name="NumberOfZipFiles">The number of zip files.</param>
        /// <returns></returns>
        public static bool setZipInWork(string FileName, int NumberOfZipFiles)
        {
            bool B = true;
            //int UseArchiveBit = 0;
            //double fSize = 0;

            string S = "Update ZipFile set InWork = 1 where FQN = @FileName) ";

            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }

            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.Parameters.AddWithValue("@FileName", FileName);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/setZipInWork - " + ex.Message + Environment.NewLine + S);
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
        /// Cleans the zip files.
        /// </summary>
        /// <returns></returns>
        public static bool cleanZipFiles()
        {
            bool B = true;
            //int UseArchiveBit = 0;
            //double fSize = 0;

            string S = "delete from ZipFile where SuccessfullyProcessed = 1 ";

            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                try
                {
                    CONN.Open();
                }
                catch (Exception ex)
                {
                    Console.WriteLine("ERROR: " + ex.Message.ToString());
                }
            }

            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/setZipNbrOfFiles - " + ex.Message + Environment.NewLine + S);
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
        /// Zeroizes the zip files.
        /// </summary>
        /// <returns></returns>
        public static bool zeroizeZipFiles()
        {
            bool B = true;
            //int UseArchiveBit = 0;
            //double fSize = 0;

            string S = "delete from ZipFile ";

            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }

            SQLiteCommand cmd = new SQLiteCommand(S, CONN);
            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/zeroizeZipFiles - " + ex.Message + Environment.NewLine + S);
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
        /// Gets the zip files.
        /// </summary>
        /// <param name="L">The l.</param>
        public static void getZipFiles(ref SortedList<string, int> L)
        {
            string FQN = null;
            SQLiteConnection CONN = new SQLiteConnection();
            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }

            string S = "Select FQN from ZipFile where InWork = 0";

            try
            {
                SQLiteCommand cmd = new SQLiteCommand(S, CONN);
                // ** if you don’t set the result set to scrollable HasRows does not work
                SQLiteDataReader rs = cmd.ExecuteReader();

                if (rs.HasRows)
                {
                    while (rs.Read())
                    {
                        FQN = rs.GetString(0);
                        if (L.ContainsKey(FQN))
                        {
                        }
                        else
                            L.Add(FQN, L.Count);
                    }
                }

                if (!rs.IsClosed)
                    rs.Close();
                rs.Dispose();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/getZipFiles - " + ex.Message + Environment.NewLine + S);
            }
            finally
            {
            }
            GC.Collect();
            GC.WaitForPendingFinalizers();
        }

        /// <summary>
        /// Gets the ce email identifiers.
        /// </summary>
        /// <param name="L">The l.</param>
        public static void getCE_EmailIdentifiers(ref SortedList L)
        {
            string sKey = null;
            int RowID = default(int);

            string S = "Select sKey,RowID from Outlook";

            if (CONN.State == ConnectionState.Closed)
            {
                CONN.ConnectionString = GetCS();
                CONN.Open();
            }

            try
            {
                SQLiteCommand cmd = new SQLiteCommand(S, CONN);
                cmd.CommandType = CommandType.Text;

                // ** if you don’t set the result set to scrollable HasRows does not work
                SQLiteDataReader rs = cmd.ExecuteReader();

                if (rs.HasRows)
                {
                    while (rs.Read())
                    {
                        sKey = rs.GetString(0);
                        RowID = rs.GetInt32(1);
                        try
                        {
                            if (!L.ContainsKey(sKey))
                                L.Add(sKey, RowID);
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine(ex.Message);
                        }
                    }
                }

                if (!rs.IsClosed)
                    rs.Close();
                rs.Dispose();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/BackupOutlookTbl - " + ex.Message + Environment.NewLine + S);
            }
            finally
            {
                if (CONN != null)
                {
                    if (CONN.State == ConnectionState.Open)
                        CONN.Close();
                }
            }
            GC.Collect();
            GC.WaitForPendingFinalizers();
        }
    }
}