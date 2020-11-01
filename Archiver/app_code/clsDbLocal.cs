using System;
using System.Collections;
using System.Collections.Generic;
using global::System.Configuration;
using System.Data;
using global::System.IO;
using System.Windows.Forms;
using global::ECMEncryption;
using global::Microsoft.Data.Sqlite;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    // Imports System.Data.SQLite

    public class clsDbLocal : IDisposable
    {
        public SqliteConnection ListernerConn = new SqliteConnection();
        private ECMEncrypt ENC = new ECMEncrypt();
        private clsLogging LOG = new clsLogging();
        private string ContactCS = "";
        private string ZipCS = "";
        private string FileCS = "";
        private string DirCS = "";
        private string InvCS = "";
        private string OutlookCS = "";
        private string ExchangeCS = "";
        private string ListenerCS = "";
        private AppDomain currDomain = AppDomain.CurrentDomain;
        public string SQLiteListenerDB = ConfigurationManager.AppSettings["SQLiteListenerDB"];
        public string DirListenerFilePath = ConfigurationManager.AppSettings["DirListenerFilePath"];

        public clsDbLocal()
        {
            currDomain.UnhandledException += modGlobals.MYExnHandler;
            Application.ThreadException += modGlobals.MYThreadHandler;
            modGlobals.setSLConn();
        }

        public bool ckListenerfileProcessed(string ListenerFileName)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            bool bProcessed = false;
            string S = "Select count(*) from ProcessedListenerFiles where ListenerFileName = '" + ListenerFileName + "' ";
            int iCnt = 0;
            bool bConnSet = false;
            bConnSet = setListenerConn();
            using (var CMD = new SqliteCommand(S, ListernerConn))
            {
                CMD.CommandText = S;
                var rdr = CMD.ExecuteReader();
                using (rdr)
                    while (rdr.Read())
                        iCnt = rdr.GetInt32(0);
            }

            if (iCnt > 0)
            {
                B = true;
            }
            else
            {
                B = false;
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();
            return bProcessed;
        }

        public List<string> getListenerfTopDir()
        {
            bConnSet = setListenerConn();
            var FilesToProcess = new List<string>();
            string sql = "select FQN from FileNeedProcessing limit 1 ;";
            string FQN = "";
            string DirName = "";
            int i = 0;
            using (var CMD = new SqliteCommand(sql, ListernerConn))
            {
                CMD.CommandText = sql;
                var rdr = CMD.ExecuteReader();
                using (rdr)
                    while (rdr.Read())
                    {
                        FQN = rdr.GetValue(0).ToString();
                        DirName = Path.GetDirectoryName(FQN);
                        if (!FilesToProcess.Contains(DirName))
                        {
                            FilesToProcess.Add(DirName);
                            break;
                        }
                    }
            }

            if (FilesToProcess.Count.Equals(0))
            {
                FilesToProcess.Add(@"C:\temp");
            }

            return FilesToProcess;
        }

        public List<string> getListenerfiles()
        {
            bConnSet = setListenerConn();
            var FilesToProcess = new List<string>();
            string sql = "select distinct FQN from FileNeedProcessing where FileApplied = 0 ;";
            string FQN = "";
            string ext = "";
            using (var CMD = new SqliteCommand(sql, ListernerConn))
            {
                CMD.CommandText = sql;
                var rdr = CMD.ExecuteReader();
                using (rdr)
                    while (rdr.Read())
                    {
                        FQN = rdr.GetValue(0).ToString();
                        ext = Path.GetExtension(FQN).ToLower().Trim();
                        if (modGlobals.gAllowedExts.Contains(ext))
                        {
                            if (!FilesToProcess.Contains(FQN))
                            {
                                FilesToProcess.Add(FQN);
                            }
                        }
                    }
            }

            return FilesToProcess;
        }

        public List<int> getListenerfilesID()
        {

            // If LConn.State.Open Then
            // LConn.Close()
            // End If

            // bConnSet = setListenerConn()

            var LConn = new SqliteConnection();
            cs = "data source=" + SQLiteListenerDB;
            LConn.ConnectionString = Conversions.ToString(cs);
            LConn.Open();
            var FilesToProcess = new List<int>();
            string sql = "select RowID from FileNeedProcessing where FileApplied = 0 ;";
            int id = -1;
            using (LConn)
            using (var CMD = new SqliteCommand(sql, LConn))
            {
                CMD.CommandText = sql;
                var rdr = CMD.ExecuteReader();
                using (rdr)
                    while (rdr.Read())
                    {
                        id = Conversions.ToInteger(rdr.GetValue(0));
                        if (!FilesToProcess.Contains(id))
                        {
                            FilesToProcess.Add(id);
                        }
                    }
            }

            return FilesToProcess;
        }

        public bool setListenerfileProcessed(string FQN)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            FQN = FQN.Replace("''", "'");
            FQN = FQN.Replace("'", "''");
            bool bProcessed = false;
            string S = "update FileNeedProcessing set FileApplied = 1 where FQN = '" + FQN + "'  ; ";
            int iCnt = 0;
            bool bConnSet = false;
            bConnSet = setListenerConn();
            var CMD = new SqliteCommand(S, ListernerConn);
            try
            {
                CMD.ExecuteNonQuery();
                bConnSet = true;
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/setListenerfileProcessed 04 - " + ex.Message + Constants.vbCrLf + S);
                bConnSet = false;
            }
            finally
            {
                CMD.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }

            return bConnSet;
        }

        public bool removeListenerfileProcessed()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            bool bProcessed = false;
            string S = "delete from FileNeedProcessing where FileApplied = 1 ; ";
            int iCnt = 0;
            bool bConnSet = false;
            bConnSet = setListenerConn();
            var CMD = new SqliteCommand(S, ListernerConn);
            try
            {
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/setListenerfileProcessed 04 - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }

            return default;
        }

        public bool removeListenerfileProcessed(List<int> RowIDs)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            if (RowIDs.Count.Equals(0))
            {
                return true;
            }

            bool b = true;
            string WC = "(";
            foreach (int ii in RowIDs)
                WC += ii.ToString() + ",";
            WC = WC.Substring(0, WC.Length - 1) + ")";
            bool bProcessed = false;
            string S = "delete from FileNeedProcessing where RowID in " + WC;
            int iCnt = 0;
            bool bConnSet = false;
            bConnSet = setListenerConn();
            var CMD = new SqliteCommand(S, ListernerConn);
            try
            {
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/removeListenerfileProcessed 88== - " + ex.Message + Constants.vbCrLf + S);
                b = false;
            }
            finally
            {
                CMD.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }

            return b;
        }

        public bool ListenerRemoveProcessed()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            bool bProcessed = false;
            string S = "delete from DirListener where FileCanBeDropped=1;";
            int iCnt = 0;
            bool bConnSet = false;
            bConnSet = setListenerConn();
            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/setListenerfileProcessed 04 - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }

            return default;
        }

        private void RecursiveSearch(ref string strDirectory, ref ArrayList array)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            var dirInfo = new DirectoryInfo(strDirectory);
            // Try to get the files for this directory
            FileInfo[] pFileInfo;
            try
            {
                pFileInfo = dirInfo.GetFiles("*.sdf");
            }
            catch (UnauthorizedAccessException ex)
            {
                MessageBox.Show(ex.Message, "Exception!", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            // Add the file infos to the array
            array.AddRange(pFileInfo);
            if (pFileInfo.Length > 0)
            {
                for (int i = 0, loopTo = array.Count - 1; i <= loopTo; i++)
                {
                    string S = array[i].ToString();
                    if (Strings.InStr(S, ":") > 0)
                    {
                    }
                    else
                    {
                        array[i] = strDirectory + @"\" + array[i].ToString();
                    }
                }
            }

            // Try to get the subdirectories of this one
            DirectoryInfo[] pdirInfo;
            try
            {
                pdirInfo = dirInfo.GetDirectories();
            }
            catch (UnauthorizedAccessException ex)
            {
                MessageBox.Show(ex.Message, "Exception!", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
                // Iterate through each directory and recurse!
            }

            foreach (var dirIter in pdirInfo)
            {
                string argstrDirectory = dirIter.FullName;
                RecursiveSearch(ref argstrDirectory, ref array);
                dirIter.FullName = argstrDirectory;
            }
        }

        ~clsDbLocal()
        {
            // If gTraceFunctionCalls.Equals(1) Then
            // LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
            // End If

            if (modGlobals.SLConn.State == ConnectionState.Open)
            {
                modGlobals.SLConn.Close();
            }

            modGlobals.SLConn.Dispose();
        } // Finalize

        public void InventoryDir(string DirName, bool bUseArchiveBit)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            bool B = true;
            int DirID = GetDirID(DirName);
            if (DirID < 0)
            {
                B = addDir(DirName, bUseArchiveBit);
                if (!B)
                {
                    LOG.WriteToArchiveLog("ERROR: clsDbLocal/InventoryDir - Failed to inventory directory '" + DirName + "'.");
                }
            }
        }

        public void InventoryFile(string FileName, string FileHash)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            bool B = true;
            int FileID = GetFileID(FileName, FileHash);
            if (FileID < 0)
            {
                B = addFile(FileName, FileHash);
                if (!B)
                {
                    LOG.WriteToArchiveLog("ERROR: clsDbLocal/InventoryDir - Failed to inventory file '" + FileName + "'.");
                }
            }
        }

        public int GetDirID(string DirName)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            DirName = DirName.Replace("'", "''");
            int DirID = -1;
            string S = "Select DirID from Directory where DirName = '" + DirName + "' ";
            // Dim cn As New SqlCeConnection(DirCS)

            modGlobals.setSLConn();
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return 0;
                }
            }

            var CMD = modGlobals.SLConn.CreateCommand();
            try
            {
                CMD.CommandText = S;

                // ** if you don’t set the result set to scrollable HasRows does not work
                // Dim rs As SqlCeResultSet = CMD.ExecuteReader()
                var rs = CMD.ExecuteReader();
                if (rs.HasRows)
                {
                    rs.Read();
                    DirID = rs.GetInt32(0);
                }
                else
                {
                    DirID = -1;
                }

                if (!rs.IsClosed)
                {
                    rs.Close();
                }

                rs.Dispose();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR XX1: clsDbLocal/GetDirID - " + ex.Message + Constants.vbCrLf + S);
                DirID = -1;
            }
            finally
            {
                CMD.Dispose();
                // If cn IsNot Nothing Then
                // If cn.State = ConnectionState.Open Then
                // cn.Close()
                // End If
                // cn.Dispose()
                // End If
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();
            return DirID;
        }

        public int GetDirID(string DirName, ref bool UseArchiveBit)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            UseArchiveBit = false;
            int DirID = -1;
            string S = "Select DirID,UseArchiveBit from Directory where DirName = '" + DirName + "' ";
            // Dim cn As New SqlCeConnection(DirCS)

            try
            {
                if (modGlobals.bSLConn.Equals(false))
                {
                    if (!modGlobals.setSLConn())
                    {
                        MessageBox.Show("NOTICE: The Local DB failed to open...");
                        return 0;
                    }
                }

                var CMD = new SqliteCommand(S, modGlobals.SLConn);
                CMD.CommandType = CommandType.Text;

                // ** if you don’t set the result set to scrollable HasRows does not work

                var rs = CMD.ExecuteReader();
                if (rs.HasRows)
                {
                    rs.Read();
                    DirID = Conversions.ToInteger(rs.GetValue(Conversions.ToInteger("DirID")));
                    UseArchiveBit = rs.GetBoolean(Conversions.ToInteger("UseArchiveBit"));
                }
                else
                {
                    UseArchiveBit = false;
                    DirID = -1;
                }

                if (!rs.IsClosed)
                {
                    rs.Close();
                }

                rs.Dispose();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR XX2: clsDbLocal/GetDirID - " + ex.Message + Constants.vbCrLf + S);
                DirID = -1;
            }
            finally
            {

                // If cn IsNot Nothing Then
                // If cn.State = ConnectionState.Open Then
                // cn.Close()
                // End If
                // cn.Dispose()
                // End If
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();
            return DirID;
        }

        public bool addDir(string FQN, bool bUseArchiveBit)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            modGlobals.setSLConn();
            bool B = true;
            int UseArchiveBit = 0;
            if (bUseArchiveBit)
            {
                UseArchiveBit = 1;
            }

            FQN = FQN.Replace("'", "''");
            string S = "insert or ignore into Directory (DirName,UseArchiveBit) values ('" + FQN + "', " + UseArchiveBit.ToString() + ") ";
            // Dim S As String = "insert or ignore into Directory (DirName,UseArchiveBit) values (@DirName, @UseArchiveBit) "

            // Dim cn As New SqlCeConnection(DirCS)

            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            string DirHash = ENC.getSha1HashKey(FQN);
            var CMD = modGlobals.SLConn.CreateCommand();
            // CMD.CommandText = "insert or ignore into directory (DirName,UseArchiveBit,DirID) values (@DirName,@UseArchiveBit,@DirHash) "
            // CMD.CommandText = "insert or ignore into directory (DirName,UseArchiveBit,DirHash) values (?,?,?) "
            CMD.CommandText = "insert or ignore into directory (DirName,UseArchiveBit,DirHash) values ('" + FQN + "'," + UseArchiveBit.ToString() + ", '" + DirHash + "') ";
            try
            {
                // CMD.Parameters.AddWithValue("DirName", FQN)
                // CMD.Parameters.AddWithValue("UseArchiveBit", UseArchiveBit)
                // CMD.Parameters.AddWithValue("DirHash", DirHash)
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/addDir - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }

            return B;
        }

        public bool delDir(string DirName)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            modGlobals.setSLConn();
            bool B = true;
            string S = "Delete from Directory where DirName = @DirName ";

            // Dim cn As New SqlCeConnection(DirCS)
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.Parameters.AddWithValue("@DirName", DirName);
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/delDir - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
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

        public int GetFileID(string FileName, string FileHash)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            modGlobals.setSLConn();
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return 0;
                }
            }

            FileName = FileName.Replace("'", "''");
            int FileID = -1;
            string S = "Select FileID from Files where FileName = '" + FileName + "' and FileHash = '" + FileHash + "' ";
            using (var CMD = new SqliteCommand(S, modGlobals.SLConn))
            {
                CMD.CommandText = S;
                var rdr = CMD.ExecuteReader();
                using (rdr)
                    while (rdr.Read())
                        FileID = rdr.GetInt32(0);
            }

            return FileID;
        }

        public bool addFile(string FileName, string FileHash)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            FileName = FileName.Replace("'", "''");
            bool B = true;
            int UseArchiveBit = 0;
            string S = "insert or ignore into Files (FileName, FileHash) values ('" + FileName + "', '" + FileHash + "') ";
            // Dim S As String = "insert or ignore into Files (FileName, FileHash) values (?,?) "
            modGlobals.setSLConn();
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            using (var CMD = new SqliteCommand(S, modGlobals.SLConn))
            {
                try
                {
                    // CMD.Parameters.AddWithValue("FileName", FileName)
                    // CMD.Parameters.AddWithValue("FileHash", FileHash)
                    CMD.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    LOG.WriteToArchiveLog("ERROR: clsDbLocal/addFile - " + ex.Message + Constants.vbCrLf + S);
                    B = false;
                }
                finally
                {
                    CMD.Dispose();
                    GC.Collect();
                    GC.WaitForPendingFinalizers();
                }
            }

            return B;
        }

        public bool addContact(string FullName, string Email1Address)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            modGlobals.setSLConn();
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            if (Email1Address is null)
            {
                Email1Address = "NA";
            }

            bool B = true;
            int UseArchiveBit = 0;
            FullName = FullName.Replace("'", "''");
            string S = "insert or ignore into ContactsArchive (Email1Address, FullName) values ('" + Email1Address + "', '" + FullName + "') ";
            using (var CMD = new SqliteCommand(S, modGlobals.SLConn))
            {
                try
                {
                    // CMD.Parameters.AddWithValue("@Email1Address", Email1Address)
                    // CMD.Parameters.AddWithValue("@FullName", FullName)
                    // CMD.Parameters.AddWithValue("@RowID", "null")
                    CMD.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    LOG.WriteToArchiveLog("ERROR: clsDbLocal/addContact - " + ex.Message + Constants.vbCrLf + S);
                    B = false;
                }
                finally
                {
                    GC.Collect();
                    GC.WaitForPendingFinalizers();
                }
            }

            return B;
        }

        public bool fileExists(string FileName)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            bool B = false;
            string S = "Select count(*) from Files where FileName = '" + FileName + "' ";
            modGlobals.setSLConn();
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            int iCnt = 0;
            using (var CMD = new SqliteCommand(S, modGlobals.SLConn))
            {
                CMD.CommandText = S;
                var rdr = CMD.ExecuteReader();
                using (rdr)
                    while (rdr.Read())
                        iCnt = rdr.GetInt32(0);
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();
            return Conversions.ToBoolean(iCnt);
        }

        public bool contactExists(string FullName, string Email1Address)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            bool B = false;
            string S = "Select count(*) from ContactsArchive where Email1Address = '" + Email1Address + "' and FullName = '" + FullName + "' ";
            modGlobals.setSLConn();
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            int iCnt = 0;
            using (var CMD = new SqliteCommand(S, modGlobals.SLConn))
            {
                CMD.CommandText = S;
                var rdr = CMD.ExecuteReader();
                using (rdr)
                    while (rdr.Read())
                        iCnt = rdr.GetInt32(0);
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();
            if (iCnt > 0)
            {
                B = true;
            }
            else
            {
                B = false;
            }

            return B;
        }

        public bool delFile(string FileName)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            modGlobals.setSLConn();
            bool B = true;
            string S = "Delete from Files where FileName = '" + FileName + "' ";
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/delFile - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
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

        public bool addInventoryForce(string FQN, bool bArchiveBit)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            modGlobals.setSLConn();
            int iArchiveFlag = 0;
            int FileExist = 1;
            int NeedsArchive = 1;
            int UseArchiveBit = 0;
            int DirID = 0;
            int FileID = 0;
            int FileSize = 0;
            bool B = true;
            var FI = new FileInfo(FQN);
            string sDirName = "";
            string sFileName = "";
            DateTime LastUpdate = default;
            int ArchiveBit = 1;
            string FileHash = "";
            if (bArchiveBit)
            {
                ArchiveBit = 1;
            }
            else
            {
                ArchiveBit = 0;
            }

            FQN = FQN.Replace("''", "'");
            FileHash = ENC.hashSha1File(FQN);
            sFileName = sFileName.Replace("''", "'");
            sDirName = sDirName.Replace("''", "'");
            try
            {
                sDirName = FI.DirectoryName;
                sFileName = FI.Name;
                FileSize = (int)FI.Length;
                LastUpdate = FI.LastWriteTime;
            }
            catch (Exception ex)
            {
                B = false;
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/addInventoryForce 00 - " + ex.Message);
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
                LOG.WriteToArchiveLog("NOTICE: clsDbLocal/setInventoryArchive 02 - Added file " + sFileName + ".");
                FileID = GetFileID(sFileName, FileHash);
            }

            if (InventoryExists(DirID, FileID, FileHash))
            {
                return true;
            }

            string S = "insert or ignore into Inventory (DirID,FileID,FileExist,FileSize,LastUpdate,ArchiveBit,NeedsArchive,FileHash) values ";
            S += "(" + DirID.ToString() + ", ";
            S += "" + FileID.ToString() + ", ";
            S += "" + FileExist.ToString() + ", ";
            S += "" + FileSize.ToString() + ", ";
            S += "'" + LastUpdate.ToString() + "', ";
            S += "" + ArchiveBit.ToString() + ", ";
            S += "" + NeedsArchive.ToString() + ", ";
            S += "'" + FileHash + "') ";

            // LOG.WriteToArchiveLog("Remove after debug  SQL: " + vbCrLf + S)

            // Dim cn As New SqlCeConnection(InvCS)
            if (!modGlobals.setSLConn())
            {
                MessageBox.Show("NOTICE: The Local DB failed to open...");
                return Conversions.ToBoolean(0);
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR 1A: clsDbLocal/addInventoryForce - " + ex.Message);
                LOG.WriteToArchiveLog("ERROR 1A: clsDbLocal/addInventoryForce SQL: " + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }

            return B;
        }

        public void RebuildDB()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            string S = "";
            S = "drop table  IF EXISTS ContactsArchive";
            ApplySQL(S);
            S = @"CREATE table [ContactsArchive] ( 
            [RowID] Integer primary key autoincrement  
	        , [Email1Address] nvarchar(100) Not NULL COLLATE NOCASE 
	        , [FullName] nvarchar(100) Not NULL COLLATE NOCASE 
        )";
            ApplySQL(S);
            S = "create index PI_CA on ContactsArchive (Email1Address, FullName);";
            ApplySQL(S);
            S = "drop table  IF EXISTS Directory;";
            ApplySQL(S);
            S = @"CREATE table [Directory] (
              [DirName] nvarchar(1000) Not NULL COLLATE NOCASE UNIQUE
            , [DirID] integer primary key autoincrement  
            , [UseArchiveBit] bit Not NULL
            , [DirHash] nvarchar(512) NULL COLLATE NOCASE
            )";
            ApplySQL(S);
            S = "create index PI_DirHash on Directory (DirHash);";
            ApplySQL(S);
            S = "create index PI_DirName on Directory (DirName);";
            ApplySQL(S);
            S = "drop table  IF EXISTS Exchange;";
            ApplySQL(S);
            S = @"CREATE table [Exchange] ( 
              [sKey] nvarchar(200) Not NULL 
            , [RowID] integer primary key autoincrement  
            , [KeyExists] bit DEFAULT 1 NULL 
            )";
            ApplySQL(S);
            S = "create index PI_KEy on Exchange (KeyExists);";
            ApplySQL(S);
            S = "drop table  IF EXISTS Files;";
            ApplySQL(S);
            S = @"CREATE table [Files] (
              [FileID] Integer primary key autoincrement  
            , [FileName] nvarchar(254) Not NULL COLLATE NOCASE
            , [FileHash] nvarchar(512) NULL COLLATE NOCASE
            )";
            ApplySQL(S);
            S = "create index PI_Hash on Files (FileHash);";
            ApplySQL(S);
            S = "create index PI_NameHash On Files (FileName, FileHash);";
            ApplySQL(S);
            S = "create index PI_FName on Files (FileName);";
            ApplySQL(S);
            S = "drop table  IF EXISTS Inventory;";
            ApplySQL(S);
            S = @"CREATE table [Inventory] (
              [InvID] Integer primary key autoincrement  
            , [DirID] int Not NULL
            , [FileID] int Not NULL
            , [FileExist] bit DEFAULT (1) NULL
            , [FileSize] bigint NULL
            , [CreateDate] datetime NULL
            , [LastUpdate] datetime NULL
            , [LastArchiveUpdate] datetime NULL
            , [ArchiveBit] bit NULL
            , [NeedsArchive] bit NULL
            , [FileHash] nvarchar(512) NULL COLLATE NOCASE
            )";
            ApplySQL(S);
            S = "create index PI_InventoryHash on Inventory (FileHash);";
            ApplySQL(S);
            S = "create index PI_Archive on Inventory (NeedsArchive);";
            ApplySQL(S);
            S = "create index PI_DirFileID On Inventory (DirID, FileID);";
            ApplySQL(S);
            S = "drop table  IF EXISTS Listener;";
            ApplySQL(S);
            S = @"CREATE table [Listener] ( 
              [FQN] nvarchar(2000) Not NULL 
            , [Uploaded] int DEFAULT 0 Not NULL 
            , CONSTRAINT Listener_pk PRIMARY KEY (FQN) 
            )";
            ApplySQL(S);
            S = "create index PI_ListenerFQN On Listener (FQN);";
            ApplySQL(S);
            S = "create index PI_ListenerUploaded On Listener (Uploaded);";
            ApplySQL(S);
            S = "drop table IF EXISTS MultiLocationFiles;";
            ApplySQL(S);
            S = @"CREATE table [MultiLocationFiles] (
              [LocID] Integer primary key autoincrement  
            , [DirID] int Not NULL
            , [FileID] int Not NULL
            , [FileHash] nvarchar(512) Not NULL COLLATE NOCASE
            )";
            ApplySQL(S);
            S = "create index PI_MFHash on MultiLocationFiles (FileHash);";
            ApplySQL(S);
            S = "create index PI_MFDirFileID On Inventory (DirID, FileID);";
            ApplySQL(S);
            S = "drop table  IF EXISTS Outlook;";
            ApplySQL(S);
            S = @"CREATE table [Outlook] ( 
  [RowID] Integer primary key autoincrement  
, [sKey] nvarchar(500) Not NULL COLLATE NOCASE UNIQUE
, [KeyExists] bit DEFAULT 1 NULL 
)";
            ApplySQL(S);
            S = "create index PI_SKey on Outlook (sKey);";
            ApplySQL(S);
            S = "create index PI_KeyExists on Outlook (KeyExists);";
            ApplySQL(S);
            S = "create index PI_OutlookSKey on Outlook (sKey);";
            ApplySQL(S);
            S = "drop table  IF EXISTS ZipFile;";
            ApplySQL(S);
            S = @"CREATE table [ZipFile] (
              [RowNbr] Integer primary key autoincrement  
            , [DirID] int NULL
            , [FileID] int NULL
            , [FQN] nvarchar(1000) Not NULL COLLATE NOCASE UNIQUE
            , [EmailAttachment] bit DEFAULT (0) NULL
            , [SuccessfullyProcessed] bit DEFAULT (0) NULL
            , [fSize] bigint NULL
            , [CreateDate] datetime Not NULL
            , [LastAccessDate] datetime NULL
            , [NumberOfZipFiles] int NULL
            , [ParentGuid] nvarchar(50) NULL COLLATE NOCASE
            , [InWork] bit DEFAULT (0) NULL
            , [FileHash] nvarchar(512) NULL COLLATE NOCASE
            )";
            ApplySQL(S);
            S = "create index PI_ZipFileHash on ZipFile (FileHash);";
            ApplySQL(S);
            S = "create index PI_ZipDirFileHash On ZipFile (DirID, FileHash);";
            ApplySQL(S);
            S = "create index PI_ZipFqn on ZipFile (FQN);";
            ApplySQL(S);
        }

        public void ApplySQL(string S)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            modGlobals.setSLConn();
            LOG.WriteToArchiveLog("NOTICE: Executing SQL: " + Constants.vbCrLf + S);

            // Dim cn As New SqlCeConnection(InvCS)
            if (!modGlobals.setSLConn())
            {
                MessageBox.Show("NOTICE: The Local DB failed to open...");
                return;
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR 1A: clsDbLocal/ApplySQL: " + ex.Message + Constants.vbCrLf + S);
                LOG.WriteToArchiveLog("ERROR 1A: clsDbLocal/ApplySQL: " + ex.Message);
                LOG.WriteToArchiveLog("ERROR 1A: clsDbLocal/ApplySQL: " + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }
        }

        public bool addInventory(int DirID, int FileID, long FileSize, DateTime LastUpdate, bool ArchiveBit, string FileHash)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            bool FileExist = true;
            bool NeedsArchive = true;
            bool B = true;
            int UseArchiveBit = 0;
            modGlobals.setSLConn();
            // Dim S As String = "insert or ignore into Directory (DirName,UseArchiveBit) values ('" + FQN + "', " + UseArchiveBit.ToString + ") "
            string S = "insert or ignore into Inventory (DirID,FileID,FileExist,FileSize,LastUpdate,ArchiveBit,NeedsArchive,FileHash) values ";
            S += "(" + DirID.ToString() + ", ";
            S += "" + FileID.ToString() + ", ";
            S += "" + FileExist.ToString() + ", ";
            S += "" + FileSize.ToString() + ", ";
            S += "'" + LastUpdate.ToString() + "', ";
            S += "" + ArchiveBit.ToString() + ", ";
            S += "" + NeedsArchive.ToString() + ", ";
            S += "'" + FileHash + "') ";

            // Dim cn As New SqlCeConnection(InvCS)
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                // CMD.Parameters.AddWithValue("@DirID", DirID)
                // CMD.Parameters.AddWithValue("@FileID", FileID)
                // CMD.Parameters.AddWithValue("@FileExist", FileExist)
                // CMD.Parameters.AddWithValue("@FileSize", FileSize)
                // CMD.Parameters.AddWithValue("@LastUpdate", LastUpdate)
                // CMD.Parameters.AddWithValue("@ArchiveBit", ArchiveBit)
                // CMD.Parameters.AddWithValue("@NeedsArchive", NeedsArchive)
                // CMD.Parameters.AddWithValue("@FileHash", FileHash)
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/addInventory - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
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

        public bool delInventory(int DirID, int FileID)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            modGlobals.setSLConn();
            int FileExist = 1;
            int NeedsArchive = 1;
            bool B = true;
            int UseArchiveBit = 0;
            string S = "delete from Inventory where DirID = " + DirID.ToString() + " and FileID = " + FileID.ToString();

            // Dim cn As New SqlCeConnection(InvCS)
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.Parameters.AddWithValue("@DirID", DirID);
                CMD.Parameters.AddWithValue("@FileID", FileID);
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/delInventory - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
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

        public bool InventoryExists(int DirID, int FileID, string CRC)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            bool B = false;
            string S = "Select FileHash from Inventory where DirID = " + DirID.ToString() + " and FileID = " + FileID.ToString();
            // Dim cn As New SqlCeConnection(InvCS)
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            int iCnt = 0;
            try
            {
                var CMD = new SqliteCommand(S, modGlobals.SLConn);
                CMD.CommandType = CommandType.Text;

                // ** if you don’t set the result set to scrollable HasRows does not work
                var rs = CMD.ExecuteReader();
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
                {
                    rs.Close();
                }

                rs.Dispose();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/InventoryExists - " + ex.Message + Constants.vbCrLf + S);
                CRC = "";
            }
            finally
            {
                // If cn IsNot Nothing Then
                // If cn.State = ConnectionState.Open Then
                // cn.Close()
                // End If
                // cn.Dispose()
                // End If
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();
            return B;
        }

        public bool InventoryHashCompare(int DirID, int FileID, string CurrHash)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            bool B = false;
            string S = "Select FileHash from Inventory where DirID = X and FileID = X ";
            // Dim cn As New SqlCeConnection(InvCS)
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            string OldHash = "";
            try
            {
                var CMD = new SqliteCommand(S, modGlobals.SLConn);
                CMD.CommandType = CommandType.Text;
                var rs = CMD.ExecuteReader();
                if (rs.HasRows)
                {
                    rs.Read();
                    OldHash = rs.GetInt32(0).ToString();
                }
                else
                {
                    OldHash = "";
                }

                if (!rs.IsClosed)
                {
                    rs.Close();
                }

                rs.Dispose();
                if (CurrHash.Equals(OldHash))
                {
                    B = true;
                }
                else
                {
                    B = false;
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/InventoryExists - " + ex.Message + Constants.vbCrLf + S);
                FileID = -1;
            }
            finally
            {
                // If cn IsNot Nothing Then
                // If cn.State = ConnectionState.Open Then
                // cn.Close()
                // End If
                // cn.Dispose()
                // End If
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();
            return B;
        }

        public bool setInventoryArchive(string FQN, bool ArchiveFlag, string FileHash)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            bool B = true;
            var FI = new FileInfo(FQN);
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
            int FileExist = 1;
            int NeedsArchive = 1;
            int UseArchiveBit = 0;
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
            {
                iArchiveFlag = 1;
            }
            else
            {
                iArchiveFlag = 0;
            }

            string S = "Update Inventory set NeedsArchive = " + iArchiveFlag.ToString();
            S += " where DirID = " + DirID.ToString() + " and FileId = " + FileID.ToString();
            modGlobals.setSLConn();
            // Dim cn As New SqlCeConnection(InvCS)
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.Parameters.AddWithValue("@DirID", DirID);
                CMD.Parameters.AddWithValue("@FileID", FileID);
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/setInventoryArchive 04 - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
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

        public bool setInventoryArchive(int DirID, int FileID, bool ArchiveFlag)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            bool B = true;
            int iArchiveFlag = 0;
            int FileExist = 1;
            int NeedsArchive = 1;
            int UseArchiveBit = 0;
            if (ArchiveFlag)
            {
                iArchiveFlag = 1;
            }
            else
            {
                iArchiveFlag = 0;
            }

            string S = "Update Inventory set NeedsArchive = " + iArchiveFlag.ToString();
            S += " where DirID = " + DirID.ToString() + " and FileId = " + FileID.ToString();
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.Parameters.AddWithValue("@DirID", DirID);
                CMD.Parameters.AddWithValue("@FileID", FileID);
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/setInventoryArchive 104 - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
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

        public string fixSingleQuotes(string str)
        {
            str = str.Replace("''", "'");
            str = str.Replace("'", "''");
            return str;
        }

        public bool updateFileArchiveInfoLastArchiveDate(string FQN)
        {
            FQN = FQN.Replace("''", "'");
            var FI = new FileInfo(FQN);
            AddFileArchiveInfo(FQN);
            FQN = fixSingleQuotes(FQN);
            bool B = false;
            string S = "update DirFilesID set LastArchiveDate = datetime(), FileLength = " + FI.Length.ToString() + ", LastModDate = '" + FI.LastWriteTime.ToString() + "'  where FQN = '" + FQN + "' ;";
            FI = null;
            modGlobals.setSLConn();
            try
            {
                var CMD = new SqliteCommand(S, modGlobals.SLConn);
                CMD.CommandType = CommandType.Text;
                CMD.ExecuteNonQuery();
                CMD.Dispose();
                B = true;
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR UpdateFileArchiveInfo 00: " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }

            return B;
        }

        public int ckFileExsists(string fqn)
        {
            int I = 0;
            string S = "";
            fqn = fixSingleQuotes(fqn);
            S = "Select count(*) From DirFilesID D  Where FQN = '" + fqn + "' ";
            modGlobals.setSLConn();
            try
            {
                var CMD = new SqliteCommand(S, modGlobals.SLConn);
                CMD.CommandType = CommandType.Text;
                var rs = CMD.ExecuteReader();
                if (rs.HasRows)
                {
                    rs.Read();
                    I = (int)rs.GetInt64(0);
                }
                else
                {
                    I = 0;
                }

                if (!rs.IsClosed)
                {
                    rs.Close();
                }

                rs.Dispose();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/InventoryExists - " + ex.Message + Constants.vbCrLf + S);
                LOG.WriteToArchiveLog("ERROR 923A getFileArchiveInfo : " + ex.Message + Constants.vbCrLf + S);
            }

            return I;
        }

        public bool AddFileArchiveInfo(string FQN)
        {
            FQN = FQN.Replace("''", "'");
            bool B = false;
            var FI = new FileInfo(FQN);
            string L = "";
            string LastWriteTime = "";
            try
            {
                L = FI.Length.ToString();
                LastWriteTime = FI.LastWriteTime.ToString();
                FQN = FQN.Replace("''", "'");
                int I = ckFileExsists(FQN);
                if (I > 0)
                {
                    return true;
                }

                FQN = FQN.Replace("''", "'");
                FQN = FQN.Replace("'", "''");
                string S = "Insert into DirFilesID (FQN, LastArchiveDate, FileLength, LastModDate) values ('" + FQN + "', '01/01/1970', " + L + ", '" + LastWriteTime + "' );";
                FI = null;
                modGlobals.setSLConn();
                try
                {
                    var CMD = new SqliteCommand(S, modGlobals.SLConn);
                    CMD.CommandType = CommandType.Text;
                    CMD.ExecuteNonQuery();
                    CMD.Dispose();
                    B = true;
                }
                catch (Exception ex)
                {
                    LOG.WriteToDirFileLog("ERROR addFileArchiveInfo 00: " + ex.Message + Constants.vbCrLf + S);
                    LOG.WriteToArchiveLog("ERROR addFileArchiveInfo 00: " + ex.Message + Constants.vbCrLf + S);
                    B = false;
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToDirFileLog("ERROR AddFileArchiveInfo 01a: " + ex.Message);
                LOG.WriteToDirFileLog("ERROR AddFileArchiveInfo 02a: skipping file : " + FQN);
                LOG.WriteToArchiveLog("ERROR AddFileArchiveInfo 01b: " + ex.Message);
                LOG.WriteToArchiveLog("ERROR AddFileArchiveInfo 02b: skipping file : " + FQN);
                B = false;
            }

            return B;
        }

        public Dictionary<string, string> getFileArchiveInfo(string FQN)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            var INFO = new Dictionary<string, string>();
            try
            {
                long FileSize = 0L;
                DateTime LastUpdate = default;
                DateTime LastArchiveDate = default;
                string S = "";
                FQN = fixSingleQuotes(FQN);
                S = "Select LastArchiveDate, FileLength, LastModDate From DirFilesID D  Where FQN = '" + FQN + "' ";
                modGlobals.setSLConn();
                try
                {
                    var CMD = new SqliteCommand(S, modGlobals.SLConn);
                    CMD.CommandType = CommandType.Text;
                    var rs = CMD.ExecuteReader();
                    if (rs.HasRows)
                    {
                        rs.Read();
                        LastArchiveDate = rs.GetDateTime(0);
                        FileSize = rs.GetInt64(1);
                        LastUpdate = rs.GetDateTime(2);
                        INFO.Add("FileSize", FileSize.ToString());
                        INFO.Add("LastUpdate", LastUpdate.ToString());
                        INFO.Add("LastArchiveDate", LastArchiveDate.ToString());
                        INFO.Add("AddNewRec", "N");
                    }
                    else
                    {
                        INFO.Add("AddNewRec", "Y");
                    }

                    if (!rs.IsClosed)
                    {
                        rs.Close();
                    }

                    rs.Dispose();
                }
                catch (Exception ex)
                {
                    LOG.WriteToArchiveLog("ERROR: clsDbLocal/InventoryExists - " + ex.Message + Constants.vbCrLf + S);
                    LOG.WriteToArchiveLog("ERROR 923A getFileArchiveInfo : " + ex.Message + Constants.vbCrLf + S);
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR 923b getFileArchiveInfo : " + ex.Message);
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();
            return INFO;
        }

        public bool ckNeedsArchive(string FQN, bool SkipIfArchiveBitOn, ref string FileHash)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            int iArchiveFlag = 0;
            int FileExist = 1;
            int NeedsArchive = 1;
            int UseArchiveBit = 0;
            int DirID = 0;
            int FileID = 0;
            int FileSize = 0;
            bool B = true;
            string sDirName = "";
            string sFileName = "";
            DateTime LastUpdate = default;
            int ArchiveBit = 1;
            if (FileHash.Length == 0)
            {
                FileHash = ENC.GenerateSHA512HashFromFile(FQN);
            }

            var fileAttributes = new FileInfo(FQN).Attributes;
            bool ArchBit = Conversions.ToBoolean(fileAttributes & FileAttributes.Archive);
            fileAttributes = default;
            if (!ArchBit & SkipIfArchiveBitOn)
            {
                return false;
            }

            if (!File.Exists(FQN))
            {
                LOG.WriteToArchiveLog("Notice: clsDbLocal/ckNeedsArchive 00 - could not find file " + FQN + ", skipping...");
                return false;
            }

            var FI = new FileInfo(FQN);
            try
            {
                sDirName = FI.DirectoryName;
                sFileName = FI.Name;
                FileSize = (int)FI.Length;
                LastUpdate = FI.LastWriteTime;
            }
            catch (Exception ex)
            {
                B = false;
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/ckNeedsArchive 00.A - ", ex);
                return B;
            }

            DirID = GetDirID(sDirName);
            FileID = GetFileID(sFileName, FileHash);
            if (DirID < 0)
            {
                B = addDir(sDirName, false);
                LOG.WriteToArchiveLog("Notice: clsDbLocal/ckNeedsArchive 01 - Added directory " + sDirName + ".");
                DirID = GetDirID(sDirName);
            }

            if (FileID < 0)
            {
                sFileName = sFileName.Replace("'", "''");
                B = addFile(sFileName, FileHash);
                LOG.WriteToArchiveLog("Notice: clsDbLocal/ckNeedsArchive 02 - Added file " + sFileName + ".");
                FileID = GetFileID(sFileName, FileHash);
            }

            bool bNeedsArchive = true;
            bool NeedsToBeArchived = true;
            bool FileExistsInInventory = true;
            FileExistsInInventory = InventoryExists(DirID, FileID, FileHash);
            if (!FileExistsInInventory)
            {
                addInventory(DirID, FileID, FileSize, LastUpdate, Conversions.ToBoolean(ArchiveBit), FileHash);
                NeedsToBeArchived = true;
                return NeedsToBeArchived;
            }

            modGlobals.setSLConn();
            string S = "Select FileSize, LastUpdate, NeedsArchive from Inventory where DirID = " + DirID.ToString() + " and FileID = " + FileID.ToString();
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            int iCnt = 0;
            int prevFileSize = 0;
            DateTime prevLastUpdate = default;
            bool prevNeedsArchive = false;
            try
            {
                var CMD = new SqliteCommand(S, modGlobals.SLConn);
                CMD.CommandType = CommandType.Text;

                // ** if you don’t set the result set to scrollable HasRows does not work
                var rs = CMD.ExecuteReader();
                if (rs.HasRows)
                {
                    rs.Read();
                    prevFileSize = (int)rs.GetInt64(0);
                    prevLastUpdate = rs.GetDateTime(1);
                    prevNeedsArchive = rs.GetBoolean(2);
                }

                if (!rs.IsClosed)
                {
                    rs.Close();
                }

                rs.Dispose();
                if (prevFileSize != FileSize)
                {
                    B = true;
                }
                else if (!prevLastUpdate.ToString().Equals(LastUpdate.ToString()))
                {
                    B = true;
                }
                else
                {
                    B = false;
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/InventoryExists - " + ex.Message + Constants.vbCrLf + S);
                FileID = -1;
            }
            finally
            {
                // If cn IsNot Nothing Then
                // If cn.State = ConnectionState.Open Then
                // cn.Close()
                // End If
                // cn.Dispose()
                // End If
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();
            return B;
        }

        public void truncateDirs()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            string S = "delete from Directory";
            modGlobals.setSLConn();
            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/truncateDirs 104 - " + ex.Message + Constants.vbCrLf + S);
            }
            finally
            {
                CMD.Dispose();
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

        public void truncateDirFiles()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            string S = "delete from DirFilesID";
            modGlobals.setSLConn();
            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/truncateContacts 104 - " + ex.Message + Constants.vbCrLf + S);
            }
            finally
            {
                CMD.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }
        }

        public void truncateContacts()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            string S = "delete from ContactsArchive";
            modGlobals.setSLConn();
            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/truncateContacts 104 - " + ex.Message + Constants.vbCrLf + S);
            }
            finally
            {
                CMD.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }
        }

        public void truncateExchange()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            string S = "delete from Exchange";
            modGlobals.setSLConn();
            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/truncateExchange 104 - " + ex.Message + Constants.vbCrLf + S);
            }
            finally
            {
                CMD.Dispose();
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

        public void truncateOutlook()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            string S = "delete from Outlook";
            modGlobals.setSLConn();
            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/truncateOutlook 104 - " + ex.Message + Constants.vbCrLf + S);
            }
            finally
            {
                CMD.Dispose();
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

        public void truncateFiles()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            string S = "delete from Files";
            modGlobals.setSLConn();
            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/truncateFiles 104 - " + ex.Message + Constants.vbCrLf + S);
            }
            finally
            {
                CMD.Dispose();
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

        public void truncateInventory()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            string S = "delete from Inventory";
            modGlobals.setSLConn();
            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/truncateInventory 104 - " + ex.Message + Constants.vbCrLf + S);
            }
            finally
            {
                CMD.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }
        }

        public void BackupDirTbl()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            modGlobals.setSLConn();
            string Dirname = null;
            int DirID = default;
            bool UseArchiveBit = default;
            string S = "Select Dirname,DirID,UseArchiveBit from Directory";
            string tPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
            string SavePath = tPath + @"\ECM\QuickRefData";
            string SaveFQN = SavePath + @"\Directory.dat";
            if (!Directory.Exists(SavePath))
            {
                Directory.CreateDirectory(SavePath);
            }

            var fOut = new StreamWriter(SaveFQN, false);
            string msg = "";
            try
            {
                var CMD = new SqliteCommand(S, modGlobals.SLConn);
                CMD.CommandType = CommandType.Text;

                // ** if you don’t set the result set to scrollable HasRows does not work
                var rs = CMD.ExecuteReader();
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
                {
                    rs.Close();
                }

                rs.Dispose();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/BackupDirTbl - " + ex.Message + Constants.vbCrLf + S);
            }
            finally
            {
                fOut.Close();
                fOut.Dispose();
                if (modGlobals.SLConn is object)
                {
                    if (modGlobals.SLConn.State == ConnectionState.Open)
                    {
                        modGlobals.SLConn.Close();
                    }

                    modGlobals.SLConn.Dispose();
                }
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();
        }

        public void BackUpSQLite()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            int BackupSQLiteHrs = Conversions.ToInteger(ConfigurationManager.AppSettings["BackupSQLiteHrs"]);
            if (BackupSQLiteHrs.Equals(0))
            {
                return;
            }

            string strPath = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().CodeBase);
            if (modGlobals.UseDebugSQLite.Equals(1))
            {
                slDatabase = ConfigurationManager.AppSettings["SQLiteDir"];
                tchar = slDatabase.Substring(Operators.SubtractObject(slDatabase.Length, 1));
                if (!tchar.Equals(@"\"))
                {
                    strPath += @"\";
                }

                if (!Directory.Exists(Conversions.ToString(slDatabase)))
                {
                    Directory.CreateDirectory(Conversions.ToString(slDatabase));
                }

                slDatabase += "EcmArchive.db";
            }
            else
            {
                tchar = strPath.Substring(strPath.Length - 1);
                if (!tchar.Equals(@"\"))
                    strPath += @"\";
                slDatabase = strPath + @"SQLiteDB\EcmArchive.db";
            }

            sSource = Operators.AddObject(slDatabase, ".bak");
            if (!File.Exists(Conversions.ToString(sSource)))
            {
                BackupSQLiteDB();
            }
            else
            {
                var cd = File.GetCreationTime(Conversions.ToString(sSource));
                int fileage = (int)DateAndTime.DateDiff(DateInterval.Hour, cd, DateAndTime.Now);
                if (fileage >= BackupSQLiteHrs)
                {
                    BackupSQLiteDB();
                }
            }
        }

        public void BackupSQLiteDB()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            string strPath = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().CodeBase);
            if (modGlobals.UseDebugSQLite.Equals(1))
            {
                slDatabase = ConfigurationManager.AppSettings["SQLiteDir"];
                tchar = slDatabase.Substring(Operators.SubtractObject(slDatabase.Length, 1));
                if (!tchar.Equals(@"\"))
                {
                    strPath += @"\";
                }

                if (!Directory.Exists(Conversions.ToString(slDatabase)))
                {
                    Directory.CreateDirectory(Conversions.ToString(slDatabase));
                }

                slDatabase += "EcmArchive.db";
            }
            else
            {
                tchar = strPath.Substring(strPath.Length - 1);
                if (!tchar.Equals(@"\"))
                    strPath += @"\";
                slDatabase = strPath + @"SQLiteDB\EcmArchive.db";
            }

            sSource = slDatabase;
            sTarget = Operators.AddObject(slDatabase, ".bak");
            if (File.Exists(Conversions.ToString(sSource)))
            {
                File.Copy(Conversions.ToString(sSource), Conversions.ToString(sTarget), true);
            }
        }

        public void RestoreSQLite()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            string strPath = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().CodeBase);
            if (modGlobals.UseDebugSQLite.Equals(1))
            {
                slDatabase = ConfigurationManager.AppSettings["SQLiteDir"];
                tchar = slDatabase.Substring(Operators.SubtractObject(slDatabase.Length, 1));
                if (!tchar.Equals(@"\"))
                {
                    strPath += @"\";
                }

                if (!Directory.Exists(Conversions.ToString(slDatabase)))
                {
                    Directory.CreateDirectory(Conversions.ToString(slDatabase));
                }

                slDatabase += "EcmArchive.db";
            }
            else
            {
                tchar = strPath.Substring(strPath.Length - 1);
                if (!tchar.Equals(@"\"))
                    strPath += @"\";
                slDatabase = strPath + @"SQLiteDB\EcmArchive.db";
            }

            sSource = Operators.AddObject(slDatabase, ".bak");
            sTarget = slDatabase;
            if (File.Exists(Conversions.ToString(sSource)))
            {
                File.Copy(Conversions.ToString(sSource), Conversions.ToString(sTarget), true);
            }
        }

        public void BackupOutlookTbl()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            modGlobals.setSLConn();
            string sKey = null;
            int RowID = default;
            string S = "Select sKey,RowID from Outlook";
            string tPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
            string SavePath = tPath + @"\ECM\QuickRefData";
            string SaveFQN = SavePath + @"\Outlook.dat";
            if (!Directory.Exists(SavePath))
            {
                Directory.CreateDirectory(SavePath);
            }

            var fOut = new StreamWriter(SaveFQN, false);
            string msg = "";
            try
            {
                var CMD = new SqliteCommand(S, modGlobals.SLConn);
                CMD.CommandType = CommandType.Text;

                // ** if you don’t set the result set to scrollable HasRows does not work
                var rs = CMD.ExecuteReader();
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
                {
                    rs.Close();
                }

                rs.Dispose();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/BackupOutlookTbl - " + ex.Message + Constants.vbCrLf + S);
            }
            finally
            {
                fOut.Close();
                fOut.Dispose();
                if (modGlobals.SLConn is object)
                {
                    if (modGlobals.SLConn.State == ConnectionState.Open)
                    {
                        modGlobals.SLConn.Close();
                    }

                    modGlobals.SLConn.Dispose();
                }
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();
        }

        public void BackupExchangeTbl()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            modGlobals.setSLConn();
            string sKey = null;
            int RowID = default;
            string S = "Select sKey,RowID from Exchange";
            modGlobals.setSLConn();
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return;
                }
            }

            string tPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
            string SavePath = tPath + @"\ECM\QuickRefData";
            string SaveFQN = SavePath + @"\Exchange.dat";
            if (!Directory.Exists(SavePath))
            {
                Directory.CreateDirectory(SavePath);
            }

            var fOut = new StreamWriter(SaveFQN, false);
            string msg = "";
            try
            {
                var CMD = new SqliteCommand(S, modGlobals.SLConn);
                CMD.CommandType = CommandType.Text;

                // ** if you don’t set the result set to scrollable HasRows does not work
                var rs = CMD.ExecuteReader();
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
                {
                    rs.Close();
                }

                rs.Dispose();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/BackupOutlookTbl - " + ex.Message + Constants.vbCrLf + S);
            }
            finally
            {
                fOut.Close();
                fOut.Dispose();
                if (modGlobals.SLConn is object)
                {
                    if (modGlobals.SLConn.State == ConnectionState.Open)
                    {
                        modGlobals.SLConn.Close();
                    }

                    modGlobals.SLConn.Dispose();
                }
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();
        }

        public bool addOutlook(string sKey)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            modGlobals.setSLConn();
            bool B = false;
            int UseArchiveBit = 0;
            B = OutlookExists(sKey);
            if (B)
            {
                return true;
            }

            string S = "insert or ignore into Outlook (sKey, RowID) values (@sKey,@RowID) ";
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.Parameters.AddWithValue("@sKey", sKey);
                CMD.Parameters.AddWithValue("@RowID", "null");
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/addOutlook - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }

            return B;
        }

        public bool addExchange(string sKey)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            modGlobals.setSLConn();
            bool B = true;
            int UseArchiveBit = 0;
            string S = "insert or ignore into Exchange (sKey,RowID) values (@sKey,@RowID) ";
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.Parameters.AddWithValue("@sKey", sKey);
                CMD.Parameters.AddWithValue("@RowID", "null");
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/addExchange - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }

            return B;
        }

        public bool OutlookExists(string sKey)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            bool B = false;
            string S = "Select count(*) from Outlook where sKey = '" + sKey + "'";
            // Dim cn As New SqlCeConnection(InvCS)

            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            int iCnt = 0;
            try
            {
                var CMD = new SqliteCommand(S, modGlobals.SLConn);
                CMD.CommandType = CommandType.Text;

                // ** if you don’t set the result set to scrollable HasRows does not work
                var rs = CMD.ExecuteReader();
                if (rs.HasRows)
                {
                    rs.Read();
                    iCnt = rs.GetInt32(0);
                }
                else
                {
                    iCnt = 0;
                }

                if (!rs.IsClosed)
                {
                    rs.Close();
                }

                rs.Dispose();
                if (iCnt > 0)
                {
                    B = true;
                }
                else
                {
                    B = false;
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/OutlookExists - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                // If cn IsNot Nothing Then
                // If cn.State = ConnectionState.Open Then
                // cn.Close()
                // End If
                // cn.Dispose()
                // End If
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();
            return B;
        }

        public bool ExchangeExists(string sKey)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            modGlobals.setSLConn();
            bool B = false;
            string S = "Select count(*) from Exchange where sKey = '" + sKey + "'";
            // Dim cn As New SqlCeConnection(InvCS)

            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            int iCnt = 0;
            try
            {
                var CMD = new SqliteCommand(S, modGlobals.SLConn);
                CMD.CommandType = CommandType.Text;

                // ** if you don’t set the result set to scrollable HasRows does not work
                var rs = CMD.ExecuteReader();
                if (rs.HasRows)
                {
                    rs.Read();
                    iCnt = rs.GetInt32(0);
                }
                else
                {
                    iCnt = 0;
                }

                if (!rs.IsClosed)
                {
                    rs.Close();
                }

                rs.Dispose();
                if (iCnt > 0)
                {
                    B = true;
                }
                else
                {
                    B = false;
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/OutlookExists - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                // If cn IsNot Nothing Then
                // If cn.State = ConnectionState.Open Then
                // cn.Close()
                // End If
                // cn.Dispose()
                // End If
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();
            return B;
        }

        public bool MarkExchangeFound(string sKey)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            modGlobals.setSLConn();
            bool B = true;
            string S = "Update exchange set KeyExists = @B where sKey = @sKey ";
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.Parameters.AddWithValue("@B", true);
                CMD.Parameters.AddWithValue("@sKey", sKey);
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/MarkExchangeFound - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
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

        public bool MarkOutlookFound(string sKey)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            bool B = true;
            string S = "Update Outlook set KeyExists = @B where sKey = @sKey ";
            modGlobals.setSLConn();
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.Parameters.AddWithValue("@B", true);
                CMD.Parameters.AddWithValue("@sKey", sKey);
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/MarkOutlookFound - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
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

        public bool delOutlook(string sKey)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            modGlobals.setSLConn();
            bool B = true;
            string S = "Delete from Outlook where sKey = @sKey ";

            // Dim cn As New SqlCeConnection(FileCS)

            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.Parameters.AddWithValue("@sKey", sKey);
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/delOutlook - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
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

        public bool delExchange(string sKey)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            modGlobals.setSLConn();
            bool B = true;
            string S = "Delete from Exchange where sKey = @sKey ";

            // Dim cn As New SqlCeConnection(FileCS)

            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.Parameters.AddWithValue("@sKey", sKey);
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/delExchange - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
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

        public bool delOutlookMissing(string sKey)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            bool B = true;
            string S = "Delete from Outlook where not keyExists  ";
            modGlobals.setSLConn();
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/delOutlookMissing - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
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

        public bool delExchangeMissing(string sKey)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            modGlobals.setSLConn();
            bool B = true;
            string S = "Delete from Exchange where not keyExists  ";
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/delExchangeMissing - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
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

        public bool setOutlookMissing()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            bool B = true;
            string S = "Update Outlook set keyExists = 0 ";
            modGlobals.setSLConn();
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/setOutlookMissing - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
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

        public bool setExchangeMissing(string sKey)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            bool B = true;
            string S = "Update Exchange set KeyExists = false ";
            modGlobals.setSLConn();
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/setExchangeMissing - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
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

        public bool setOutlookKeyFound(string sKey)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            if (sKey.Length > 500)
            {
                sKey = sKey.Substring(0, 499);
            }

            bool B = true;
            string S = "Udpate Outlook set keyExists = true where sKey = '" + sKey + "'  ";
            modGlobals.setSLConn();
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                // CMD.Parameters.AddWithValue("@sKey", sKey)
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("WARNING: clsDbLocal/setOutlookKeyFound - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }

            return B;
        }

        public bool setExchangeKeyFound(string sKey)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            bool B = true;
            string S = "Udpate Exchange set keyExists = true where sKey = @sKey  ";
            modGlobals.setSLConn();
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.Parameters.AddWithValue("@sKey", sKey);
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/setExchangeKeyFound - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }

            return B;
        }

        public void LoadExchangeKeys(ref SortedList<string, string> L)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            string S = "Select sKey from Exchange";
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return;
                }
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            string sKey = "";
            try
            {
                CMD.CommandType = CommandType.Text;

                // ** if you don’t set the result set to scrollable HasRows does not work
                var rs = CMD.ExecuteReader();
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
                {
                    rs.Close();
                }

                rs.Dispose();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/BackupDirTbl - " + ex.Message + Constants.vbCrLf + S);
            }
            finally
            {
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();
        }

        public bool addListener(string FQN)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            modGlobals.setSLConn();
            bool B = true;
            string S = "insert or ignore into Listener (FQN) values (@FQN) ";
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.Parameters.AddWithValue("@FQN", FQN);
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/addListener - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }

            return B;
        }

        public bool DelListenersProcessed()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            bool B = true;
            string S = "delete from Listener where Uploaded = 1";
            modGlobals.setSLConn();
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                // CMD.Parameters.AddWithValue("@FQN", FQN)
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/addListener - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }

            return B;
        }

        public bool MarkListenersProcessed(string FQN)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            bool B = true;
            string S = "Update Listener set Uploaded = 1 where FQN = @FQN";
            modGlobals.setSLConn();
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.Parameters.AddWithValue("@FQN", FQN);
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/addListener - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }

            return B;
        }

        public bool removeListenerFile(string FQN)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            bool B = true;
            string S = "Delete from Listener where FQN = @FQN";
            modGlobals.setSLConn();
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.Parameters.AddWithValue("@FQN", FQN);
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/addListener - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }

            return B;
        }

        public void getListenerFiles(ref SortedList<string, int> L)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            modGlobals.setSLConn();
            string FQN = null;
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return;
                }
            }

            string S = "Select FQN from Listener";
            try
            {
                var CMD = new SqliteCommand(S, modGlobals.SLConn);
                // ** if you don’t set the result set to scrollable HasRows does not work
                var rs = CMD.ExecuteReader();
                if (rs.HasRows)
                {
                    while (rs.Read())
                    {
                        FQN = rs.GetString(0);
                        if (L.ContainsKey(FQN))
                        {
                        }
                        else
                        {
                            L.Add(FQN, L.Count);
                        }
                    }
                }

                if (!rs.IsClosed)
                {
                    rs.Close();
                }

                rs.Dispose();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/getListenerFiles - " + ex.Message + Constants.vbCrLf + S);
            }
            finally
            {
                // If SLConn IsNot Nothing Then
                // If SLConn.State = ConnectionState.Open Then
                // SLConn.Close()
                // End If
                // SLConn.Dispose()
                // End If
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();
        }

        public bool ActiveListenerFiles()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            bool B = false;
            string S = "Select count(*) from Listener ";
            // Dim cn As New SqlCeConnection(InvCS)

            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            int iCnt = 0;
            try
            {
                var CMD = new SqliteCommand(S, modGlobals.SLConn);
                // ** if you don’t set the result set to scrollable HasRows does not work
                var rs = CMD.ExecuteReader();
                if (rs.HasRows)
                {
                    rs.Read();
                    iCnt = rs.GetInt32(0);
                }
                else
                {
                    iCnt = 0;
                }

                if (!rs.IsClosed)
                {
                    rs.Close();
                }

                rs.Dispose();
                if (iCnt > 0)
                {
                    B = true;
                }
                else
                {
                    B = false;
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/ActiveListenerFiles - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                // If cn IsNot Nothing Then
                // If cn.State = ConnectionState.Open Then
                // cn.Close()
                // End If
                // cn.Dispose()
                // End If
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();
            return B;
        }

        public bool addZipFile(string FileName, string ParentGuid, bool bThisIsAnEmail)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            int EmailAttachment = 0;
            bool B = true;
            int UseArchiveBit = 0;
            double fSize = 0d;
            if (bThisIsAnEmail)
            {
                EmailAttachment = 1;
            }

            var FI = new FileInfo(FileName);
            fSize = FI.Length;
            FI = null;
            string S = "";
            S = S + "insert or ignore into ZipFile (FQN, fSize, EmailAttachment,RowNbr) values (@FileName, @fSize, @EmailAttachment, @RowNbr) ";
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.Parameters.AddWithValue("@FileName", FileName);
                CMD.Parameters.AddWithValue("@fSize", fSize);
                CMD.Parameters.AddWithValue("@ParentGuid", ParentGuid);
                CMD.Parameters.AddWithValue("@EmailAttachment", EmailAttachment);
                CMD.Parameters.AddWithValue("@RowNbr", "null");
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                if (Strings.InStr(ex.Message, "duplicate value cannot") > 0)
                {
                }
                else
                {
                    LOG.WriteToArchiveLog("ERROR: clsDbLocal/addFile - " + ex.Message + Constants.vbCrLf + S);
                }

                B = false;
            }
            finally
            {
                CMD.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }

            return B;
        }

        public bool setZipFileProcessed(string FileName)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            bool B = true;
            int UseArchiveBit = 0;
            double fSize = 0d;
            var FI = new FileInfo(FileName);
            fSize = FI.Length;
            FI = null;
            string S = "Update ZipFile set SuccessfullyProcessed = 1 where FQN = @FileName) ";
            modGlobals.setSLConn();
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.Parameters.AddWithValue("@FileName", FileName);
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/setZipFileProcessed - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }

            return B;
        }

        public bool setZipNbrOfFiles(string FileName, int NumberOfZipFiles)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            bool B = true;
            int UseArchiveBit = 0;
            double fSize = 0d;
            string S = "Update ZipFile set NumberOfZipFiles = " + NumberOfZipFiles.ToString() + " where FQN = @FileName) ";
            modGlobals.setSLConn();
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.Parameters.AddWithValue("@FileName", FileName);
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/setZipNbrOfFiles - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }

            return B;
        }

        public bool setZipInWork(string FileName, int NumberOfZipFiles)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            bool B = true;
            int UseArchiveBit = 0;
            double fSize = 0d;
            string S = "Update ZipFile set InWork = 1 where FQN = @FileName) ";
            modGlobals.setSLConn();
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.Parameters.AddWithValue("@FileName", FileName);
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/setZipInWork - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }

            return B;
        }

        public bool cleanZipFiles()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            modGlobals.setSLConn();
            bool B = true;
            int UseArchiveBit = 0;
            double fSize = 0d;
            string S = "delete from ZipFile where SuccessfullyProcessed = 1 ";
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/setZipNbrOfFiles - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }

            return B;
        }

        public bool zeroizeZipFiles()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            bool B = true;
            int UseArchiveBit = 0;
            double fSize = 0d;
            string S = "delete from ZipFile ";
            modGlobals.setSLConn();
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SqliteCommand(S, modGlobals.SLConn);
            try
            {
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/zeroizeZipFiles - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }

            return B;
        }

        public void getZipFiles(ref SortedList<string, int> L)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            modGlobals.setSLConn();
            string FQN = null;
            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return;
                }
            }

            string S = "Select FQN from ZipFile where InWork = 0";
            try
            {
                var CMD = new SqliteCommand(S, modGlobals.SLConn);
                // ** if you don’t set the result set to scrollable HasRows does not work
                var rs = CMD.ExecuteReader();
                if (rs.HasRows)
                {
                    while (rs.Read())
                    {
                        FQN = rs.GetString(0);
                        if (L.ContainsKey(FQN))
                        {
                        }
                        else
                        {
                            L.Add(FQN, L.Count);
                        }
                    }
                }

                if (!rs.IsClosed)
                {
                    rs.Close();
                }

                rs.Dispose();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/getZipFiles - " + ex.Message + Constants.vbCrLf + S);
            }
            finally
            {
                // If SLConn IsNot Nothing Then
                // If SLConn.State = ConnectionState.Open Then
                // SLConn.Close()
                // End If
                // SLConn.Dispose()
                // End If
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();
        }

        public void getCE_EmailIdentifiers(ref SortedList L)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            string sKey = null;
            int RowID = default;
            string S = "Select sKey,RowID from Outlook";
            if (modGlobals.bSLConn.Equals(false))
            {
                modGlobals.setSLConn();
            }

            if (modGlobals.bSLConn.Equals(false))
            {
                if (!modGlobals.setSLConn())
                {
                    MessageBox.Show("NOTICE: The Local DB failed to open...");
                    return;
                }
            }

            try
            {
                var CMD = new SqliteCommand(S, modGlobals.SLConn);
                CMD.CommandType = CommandType.Text;

                // ** if you don’t set the result set to scrollable HasRows does not work
                var rs = CMD.ExecuteReader();
                if (rs.HasRows)
                {
                    while (rs.Read())
                    {
                        sKey = rs.GetString(0);
                        RowID = rs.GetInt32(1);
                        try
                        {
                            if (!L.ContainsKey(sKey))
                            {
                                L.Add(sKey, RowID);
                            }
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine(ex.Message);
                        }
                    }
                }

                if (!rs.IsClosed)
                {
                    rs.Close();
                }

                rs.Dispose();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/BackupOutlookTbl - " + ex.Message + Constants.vbCrLf + S);
            }
            finally
            {
                if (modGlobals.SLConn is object)
                {
                    if (modGlobals.SLConn.State == ConnectionState.Open)
                    {
                        modGlobals.SLConn.Close();
                    }
                }
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();
        }

        public bool setListenerConn()
        {
            if (!File.Exists(SQLiteListenerDB))
            {
                LOG.WriteToArchiveLog("FATAL ERROR: Listener SQLite DB does not exist: " + SQLiteListenerDB);
                MessageBox.Show("FATAL ERROR: Listener SQLite DB does not exist: " + SQLiteListenerDB);
                return false;
            }

            bool bb = true;
            if (!ListernerConn.State.Equals(ConnectionState.Open))
            {
                try
                {
                    cs = "data source=" + SQLiteListenerDB;
                    ListernerConn.ConnectionString = Conversions.ToString(cs);
                    ListernerConn.Open();
                    bb = true;
                }
                // bSLConn = True
                catch (Exception ex)
                {
                    bb = false;
                    // bSLConn = False
                }
            }

            return bb;
        }

        public static bool CreateSQLiteDB(string dbfqn)
        {
            if (File.Exists(dbfqn))
            {
                return true;
            }

            try
            {
                int i = 0;
                string AppPath = AppDomain.CurrentDomain.BaseDirectory;
                var files = Directory.GetFiles(AppPath, "EcmArchive.db", SearchOption.AllDirectories);
                string DBName = "";
                string TgtDir = "";
                slDatabase = ConfigurationManager.AppSettings["SQLiteDir"];
                if (!Directory.Exists(dbfqn))
                {
                    Directory.CreateDirectory(dbfqn);
                }

                if (files.Length > 0)
                {
                    var loopTo = files.Length - 1;
                    for (i = 0; i <= loopTo; i++)
                    {
                        DBName = files[i];
                        if (DBName.ToUpper().Contains("EcmArchive.db"))
                        {
                            string fileToCopy = files[i];
                            string destinationDirectory = dbfqn;
                            File.Copy(fileToCopy, destinationDirectory);
                            break;
                        }
                    }
                }

                return true;
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR addSQLiteDB: " + ex.Message);
                return false;
            }
        }

        /* TODO ERROR: Skipped RegionDirectiveTrivia */
        private bool disposedValue; // To detect redundant calls

        // IDisposable
        protected virtual void Dispose(bool disposing)
        {
            if (!disposedValue)
            {
                if (disposing)
                {
                    // TODO: dispose managed state (managed objects).
                    currDomain.UnhandledException -= modGlobals.MYExnHandler;
                    Application.ThreadException -= modGlobals.MYThreadHandler;
                }

                // TODO: free unmanaged resources (unmanaged objects) and override Finalize() below.
                // TODO: set large fields to null.
            }

            disposedValue = true;
        }

        // TODO: override Finalize() only if Dispose(disposing As Boolean) above has code to free unmanaged resources.
        // Protected Overrides Sub Finalize()
        // ' Do not change this code.  Put cleanup code in Dispose(disposing As Boolean) above.
        // Dispose(False)
        // MyBase.Finalize()
        // End Sub

        // This code added by Visual Basic to correctly implement the disposable pattern.
        public void Dispose()
        {
            // Do not change this code.  Put cleanup code in Dispose(disposing As Boolean) above.
            Dispose(true);
            // TODO: uncomment the following line if Finalize() is overridden above.
            // GC.SuppressFinalize(Me)
        }
        /* TODO ERROR: Skipped EndRegionDirectiveTrivia */
    }
}