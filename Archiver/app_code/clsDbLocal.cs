using System;
using System.Collections;
using System.Collections.Generic;
using global::System.Configuration;
using System.Data;
// Imports Microsoft.Data.Sqlite
using global::System.Data.SQLite;
using global::System.IO;
using System.Linq;
using System.Windows.Forms;
using global::ECMEncryption;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public class clsDbLocal : IDisposable
    {
        public SQLiteConnection ListernerConn = new SQLiteConnection();
        private ECMEncrypt ENC = new ECMEncrypt();
        private clsLogging LOG = new clsLogging();
        public bool bSQLiteCOnnected = false;
        public SQLiteConnection SQLiteCONN = new SQLiteConnection();
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
            setSLConn();
        }

        public void ReInventory()
        {
            try
            {
                var FRM = new frmNotify();
                FRM.Show();
                FRM.Title = "RE-INVENTORY";
                var DictOfDirs = new Dictionary<string, string>();
                string[] Arr = null;
                var DB = new clsDatabaseARCH();
                string[] aFolders = null;
                bool bUseArchiveBit = false;
                FileInfo FI = null;
                DirectoryInfo di = null;
                string hash = "";
                int iCnt = 0;
                int iTot = 0;
                string DirName = "";
                string IncludeSubDirs = "";
                string DB_ID = "";
                string VersionFiles = "";
                string DisableFolder = "";
                string OcrDirectory = "";
                string RetentionCode = "";
                int DirID = 0;
                int FileID = 0;
                string EXT = "";
                string FQN = "";
                long FSize = 0L;
                DateTime LastWriteTime = default;
                DateTime CreationTime = default;
                bool B = true;
                string CurrDir = "";

                // WDM COMMENTED OUT Nov-01-2020
                // Dim AllowedExts As List(Of String) = DB.getUsersAllowedFileExt(gCurrUserGuidID)

                truncateDirs();
                truncateFiles();
                truncateInventory();
                // DBLocal.truncateOutlook()
                // DBLocal.truncateExchange()
                // DBLocal.truncateContacts()
                truncateDirFiles();

                // aFolders(0) = FQN + "|" + IncludeSubDirs + "|" + DB_ID + "|" + VersionFiles + "|" + DisableFolder + "|" + OcrDirectory + "|" + RetentionCode
                // DB.GetContentArchiveFileFolders(gCurrLoginID, aFolders)
                DictOfDirs = DB.GetUserDirectories(modGlobals.gCurrLoginID);
                int ExtCnt = 0;
                int LastIdx = 0;
                var DirWhereInClause = new Dictionary<string, string>();
                var DictDirID = new Dictionary<string, int>();
                string WC = "";
                foreach (string DKey in DictOfDirs.Keys)
                {
                    addDir(DKey, bUseArchiveBit);
                    DirID = GetDirID(DKey);
                    DictDirID.Add(DKey, DirID);
                    // WDM Commented out the below 11-02-2020 The day before we DUMP TRUMP
                    // WC = DB.getIncludedFileTypeWhereIn(gCurrLoginID, DKey)
                    // If WC.Length > 0 Then
                    // If Not DirWhereInClause.Keys.Contains(DKey) Then
                    // DirWhereInClause.Add(DKey, WC)
                    // End If
                    // End If
                }

                var DictOfWC = new Dictionary<string, string>();
                DictOfWC = DB.getIncludedFileTypeWhereIn(modGlobals.gCurrLoginID);
                foreach (string str in DictOfDirs.Keys)
                {
                    try
                    {
                        DirName = str;
                        // ********************************
                        // WDM Commented out 11-02-2020 Reight before we cast trump into a lake of fire and brimstone
                        // WC = DirWhereInClause(str)
                        WC = getAllowedExtension(str, 0, DictOfWC);
                        // ********************************
                        if (Directory.Exists(DirName))
                        {
                            IncludeSubDirs = DictOfDirs[str];
                            Application.DoEvents();
                            ExtCnt = 0;
                            LastIdx = 0;

                            // ** WDM Commented out Nov-01-2020
                            // addDir(DirName, bUseArchiveBit)
                            // DirID = GetDirID(DirName)

                            DirID = DictDirID[str];
                            if (IncludeSubDirs.ToUpper().Equals("Y"))
                            {
                                iCnt = 0;
                                di = new DirectoryInfo(DirName);
                                foreach (var currentFI in di.GetFiles("*.*", SearchOption.AllDirectories))
                                {
                                    FI = currentFI;
                                    try
                                    {
                                        iCnt += 1;
                                        FQN = FI.FullName;
                                        FSize = FI.Length;
                                        LastWriteTime = FI.LastWriteTime;
                                        CreationTime = FI.CreationTime;
                                        EXT = FI.Extension.ToLower();
                                        CurrDir = FI.DirectoryName;
                                        FRM.Label1.Text = CurrDir;
                                        if (!FQN.Contains(@"\.git"))
                                        {
                                            if (WC.Contains(EXT + ","))
                                            {
                                                FRM.lblPdgPages.Text = FI.Name + " @ " + FI.Length.ToString();
                                                FRM.lblFileSpec.Text = iCnt.ToString();
                                                hash = ENC.SHA512SqlServerHash(FI.FullName);
                                                B = addFile(FI.Name, hash);
                                                FileID = GetFileID(FI.Name, hash);
                                                // hash = ENC.SHA512SqlServerHash(FI.FullName)
                                                B = addInventory(DirID, FileID, FI.Length, LastWriteTime, false, hash);
                                            }
                                        }
                                        else
                                        {
                                            Console.WriteLine("*");
                                        }
                                    }
                                    catch (Exception ex)
                                    {
                                        LOG.WriteToArchiveLog("ERROR 01 Reinventory: " + ex.Message);
                                    }

                                    Application.DoEvents();
                                }
                            }
                            else
                            {
                                di = new DirectoryInfo(DirName);
                                foreach (var currentFI1 in di.GetFiles("*.*", SearchOption.TopDirectoryOnly))
                                {
                                    FI = currentFI1;
                                    try
                                    {
                                        iCnt += 1;
                                        FQN = FI.FullName;
                                        FSize = FI.Length;
                                        LastWriteTime = FI.LastWriteTime;
                                        CreationTime = FI.CreationTime;
                                        EXT = FI.Extension;
                                        if (!FQN.Contains(@"\.git"))
                                        {
                                            CurrDir = FI.DirectoryName;
                                            FRM.Label1.Text = CurrDir;
                                            if (WC.Contains(EXT + ","))
                                            {
                                                FRM.lblPdgPages.Text = FI.Name + " @ " + FI.Length.ToString();
                                                FRM.lblFileSpec.Text = iCnt.ToString();
                                                hash = ENC.SHA512SqlServerHash(FI.FullName);
                                                B = addFile(FI.Name, hash);
                                                FileID = GetFileID(FI.Name, hash);
                                                // hash = ENC.SHA512SqlServerHash(FI.FullName)
                                                B = addInventory(DirID, FileID, FI.Length, LastWriteTime, false, hash);
                                            }
                                        }
                                        else
                                        {
                                            Console.WriteLine("-");
                                        }
                                    }
                                    catch (Exception ex)
                                    {
                                        LOG.WriteToArchiveLog("ERROR 02 Reinventory: " + ex.Message);
                                    }
                                }

                                Application.DoEvents();
                            }
                        }
                        else
                        {
                            LOG.WriteToArchiveLog("ERROR Missing Directory on this machine: " + DirName);
                        }
                    }
                    catch (Exception ex)
                    {
                        LOG.WriteToArchiveLog("ERROR X03 Reinventory: " + ex.Message);
                    }
                }

                FRM.Close();
                FRM = null;
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR 00 Reinventory: " + ex.Message);
            }
        }

        public string getAllowedExtension(string DirName, int Level, Dictionary<string, string> tDict)
        {
            DirName = DirName.ToLower();
            string TempDir = DirName;
            bool FoundIt = false;
            string WC = "";
            int iLoc = 0;
            while (!FoundIt & TempDir.Length >= 3)
            {
                if (tDict.Keys.Contains(TempDir))
                {
                    FoundIt = true;
                    WC = tDict[TempDir];
                    break;
                }
                else
                {
                    iLoc = TempDir.LastIndexOf(@"\");
                    TempDir = TempDir.Substring(0, iLoc);
                }
            }

            return WC;
        }

        public List<string> getAllowedExtension(string DirName, int Level)
        {
            var DB = new clsDatabaseARCH();
            var L = new List<string>();
            var LB = new ListBox();
            DB.LoadIncludedFileTypes(ref LB, modGlobals.gCurrLoginID, DirName);
            foreach (string strext in LB.Items)
            {
                if (!L.Contains(strext))
                {
                    L.Add(strext);
                }
            }

            LB = null;
            DB.Dispose();
            if (L.Count.Equals(0))
            {
                Level += 1;
                int I = DirName.LastIndexOf(@"\");
                DirName = DirName.Substring(0, I);
                if (DirName.Length < 4)
                {
                    return L;
                }

                L = getAllowedExtension(DirName, Level);
            }

            return L;
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
            using (var CMD = new SQLiteCommand(S, ListernerConn))
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
            using (var CMD = new SQLiteCommand(sql, ListernerConn))
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
            var DB = new clsDatabaseARCH();
            var FRM = new frmNotify();
            FRM.Show();
            FRM.Title = "Getting LISTENER Files";
            FRM.Text = "Getting LISTENER Files";
            bConnSet = setListenerConn();
            var FilesToProcess = new List<string>();
            string sql = "select distinct FQN from FileNeedProcessing where FileApplied = 0 order by FQN ;";
            string FQN = "";
            string ext = "";
            string DIR = "";
            List<string> AllowedExts = null;
            // C:\Users\wdale\Documents\Outlook Files
            int ExtCnt = 0;
            int LastIdx = 0;
            long Len = 0L;


            // Dim DirWhereInClause As New Dictionary(Of String, String)
            // Dim DictDirID As New Dictionary(Of String, Integer)
            // Dim WC As String = ""
            // For Each DKey As String In DictOfDirs.Keys
            // WC = DB.getIncludedFileTypeWhereIn(gCurrLoginID)
            // Next

            var DictOfDirs = new Dictionary<string, string>();
            DictOfDirs = DB.getIncludedFileTypeWhereIn(modGlobals.gCurrLoginID);
            string DirExts = "";
            using (var CMD = new SQLiteCommand(sql, ListernerConn))
            {
                CMD.CommandText = sql;
                var rdr = CMD.ExecuteReader();
                int iCnt = 0;
                using (rdr)
                    while (rdr.Read())
                    {
                        iCnt += 1;
                        FQN = rdr.GetValue(0).ToString();
                        FRM.lblFileSpec.Text = iCnt.ToString();
                        if (!FQN.Contains(@"\.git"))
                        {
                            try
                            {
                                var FI = new FileInfo(FQN);
                                ext = FI.Extension;
                                DIR = FI.DirectoryName;
                                Len = FI.Length;
                                if (ext.Length > 0)
                                {
                                    // WDM Commented Out the below Nov-02-2020 (day before we get rid of trump)
                                    // AllowedExts = getAllowedExtension(DIR, 0)
                                    DirExts = getAllowedExtension(DIR, 0, DictOfDirs);
                                    // If AllowedExts.Contains(ext) Then
                                    if (DirExts.Contains(ext + ","))
                                    {
                                        if (!FilesToProcess.Contains(FQN))
                                        {
                                            FRM.lblPdgPages.Text = "Processing: " + FQN;
                                            FilesToProcess.Add(FQN);
                                        }
                                    }
                                }
                            }
                            catch (Exception ex)
                            {
                                LOG.WriteToArchiveLog("ERROR getListenerFiles 02: " + ex.Message);
                            }
                        }

                        FRM.Refresh();
                        Application.DoEvents();
                    }
            }

            FRM.Close();
            FRM.Dispose();
            return FilesToProcess;
        }

        public List<string> getListenerfilesID()
        {
            var LConn = new SQLiteConnection();
            cs = "data source=" + SQLiteListenerDB;
            LConn.ConnectionString = Conversions.ToString(cs);
            LConn.Open();
            var FilesToProcess = new List<string>();
            string sql = "select RowID from FileNeedProcessing where FileApplied = 0 ;";
            string id = "";
            using (LConn)
            using (var CMD = new SQLiteCommand(sql, LConn))
            {
                CMD.CommandText = sql;
                var rdr = CMD.ExecuteReader();
                using (rdr)
                    while (rdr.Read())
                    {
                        id = rdr.GetValue(0).ToString();
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
            var CMD = new SQLiteCommand(S, ListernerConn);
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

            bool B = true;
            bool bProcessed = false;
            string S = "delete from FileNeedProcessing where FileApplied = 1 ; ";
            int iCnt = 0;
            bool bConnSet = false;
            bConnSet = setListenerConn();
            var CMD = new SQLiteCommand(S, ListernerConn);
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

        public bool removeListenerfileProcessed(List<string> RowIDs)
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
            foreach (string ii in RowIDs)
                WC += ii + ",";
            WC = WC.Substring(0, WC.Length - 1) + ")";
            WC += " OR FileApplied= 1";
            bool bProcessed = false;
            string S = "delete from FileNeedProcessing where RowID in " + WC;
            // Dim S As String = "delete from FileNeedProcessing where FileApplied= 1"
            int iCnt = 0;
            bool bConnSet = false;
            bConnSet = setListenerConn();
            var CMD = new SQLiteCommand(S, ListernerConn);
            try
            {
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/removeListenerfileProcessed 8 - " + ex.Message + Constants.vbCrLf + S);
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
            var CMD = new SQLiteCommand(S, SQLiteCONN);
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

            if (!Information.IsNothing(SQLiteCONN))
            {
                try
                {
                    if (SQLiteCONN.State == ConnectionState.Open)
                    {
                        SQLiteCONN.Close();
                    }

                    try
                    {
                        SQLiteCONN.Dispose();
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine("INFO: SQLiteConn Dispose" + ex.Message);
                    }
                }
                catch (Exception ex)
                {
                    if (!ex.Message.Contains("Cannot access a disposed object"))
                    {
                        LOG.WriteToArchiveLog("NOTICE: SQLiteConn closed" + ex.Message);
                    }
                    else
                    {
                        Console.WriteLine("INFO: SQLiteConn Dispose" + ex.Message);
                    }
                }
            }
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

            if (DirName.Contains("'"))
            {
                DirName = DirName.Replace("'", "''");
            }

            int DirID = -1;
            string S = "Select DirID from Directory where DirName = '" + DirName + "' ";
            // Dim cn As New SqlCeConnection(DirCS)

            setSLConn();
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 01: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return 0;
                }
            }

            var CMD = SQLiteCONN.CreateCommand();
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
                if (bSQLiteCOnnected.Equals(false))
                {
                    if (!setSLConn())
                    {
                        MessageBox.Show("NOTICE 02: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                        return 0;
                    }
                }

                var CMD = new SQLiteCommand(S, SQLiteCONN);
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

            setSLConn();
            bool B = true;
            int UseArchiveBit = 0;
            if (bUseArchiveBit)
            {
                UseArchiveBit = 1;
            }

            if (FQN.Contains("'"))
            {
                FQN = FQN.Replace("'", "''");
            }

            string S = "insert or ignore into Directory (DirName,UseArchiveBit) values ('" + FQN + "', " + UseArchiveBit.ToString() + ") ";
            // Dim S As String = "insert or ignore into Directory (DirName,UseArchiveBit) values (@DirName, @UseArchiveBit) "

            // Dim cn As New SqlCeConnection(DirCS)

            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 03: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            string DirHash = ENC.SHA512String(FQN);
            var CMD = SQLiteCONN.CreateCommand();
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

        public bool resetExtension()
        {
            bool B = true;
            try
            {
                var SLConn = new SQLiteConnection();
                string S = "update Exts set Validated = 0";
                string slDatabase = ConfigurationManager.AppSettings["SQLiteListenerDB"];
                if (!File.Exists(slDatabase))
                {
                    MessageBox.Show("FATAL ERR SQLite DB MISSING: " + slDatabase);
                }

                string ConnStr = "data source=" + slDatabase;
                using (SLConn)
                {
                    SLConn.ConnectionString = ConnStr;
                    SLConn.Open();
                    var CMD = new SQLiteCommand(S, SLConn);
                    using (CMD)
                        try
                        {
                            CMD.CommandText = S;
                            CMD.ExecuteNonQuery();
                        }
                        catch (Exception ex)
                        {
                            LOG.WriteToArchiveLog("ERROR 01: clsDbLocal/resetExtension 01 - " + ex.Message + Constants.vbCrLf + S);
                            B = false;
                        }
                }

                B = true;
            }
            catch (Exception ex)
            {
                B = false;
                LOG.WriteToArchiveLog("ERROR 01: clsDbLocal/resetExtension 02 - " + ex.Message);
            }

            return B;
        }

        public bool addExtension(List<string> AllowedExts)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            string WC = "(";
            string WhereNotIN = "where Extension not in ";
            string WhereIN = "where Extension in ";
            bool B = true;
            string S = "";
            string ext = "";
            foreach (string xt in AllowedExts)
                WC += "'" + xt + "',";
            WC = WC.Substring(0, WC.Length - 1);
            WC = WC.Trim() + ")";
            WhereNotIN += WC;
            WhereIN += WC;
            bConnSet = setListenerConn();
            if (bConnSet.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 04: The Listener DB failed to open.: " + ListenerCS);
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = ListernerConn.CreateCommand();
            try
            {
                CMD.CommandText = "delete from Exts " + WhereNotIN;
                CMD.ExecuteNonQuery();
                foreach (string xt in AllowedExts)
                {
                    CMD.CommandText = "insert or ignore into Exts (Extension,Validated) values ('" + ext + "',1)";
                    CMD.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/addExtension - " + ex.Message + Constants.vbCrLf + S);
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

            setSLConn();
            bool B = true;
            string S = "Delete from Directory where DirName = @DirName ";

            // Dim cn As New SqlCeConnection(DirCS)
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 05: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
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

            setSLConn();
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 06: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return 0;
                }
            }

            if (FileName.Contains("''"))
            {
                FileName = FileName.Replace("''", "'");
            }

            if (FileName.Contains("'"))
            {
                FileName = FileName.Replace("''", "'");
                FileName = FileName.Replace("'", "''");
            }

            int FileID = -1;
            string S = "Select FileID from Files where FileName = '" + FileName + "' and FileHash = '" + FileHash + "' ";
            try
            {
                using (var CMD = new SQLiteCommand(S, SQLiteCONN))
                {
                    CMD.CommandText = S;
                    var rdr = CMD.ExecuteReader();
                    using (rdr)
                        while (rdr.Read())
                            FileID = rdr.GetInt32(0);
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR cbLocalDB/GetFileID: " + ex.Message + Constants.vbCrLf + S);
            }

            return FileID;
        }

        public bool addFile(string FileName, string FileHash)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            if (FileName.Contains("'"))
            {
                FileName = FileName.Replace("''", "'");
                FileName = FileName.Replace("'", "''");
            }

            bool B = true;
            int UseArchiveBit = 0;
            string S = "insert or ignore into Files (FileName, FileHash) values ('" + FileName + "', '" + FileHash + "') ";
            // Dim S As String = "insert or ignore into Files (FileName, FileHash) values (?,?) "
            B = setSLConn();
            try
            {
                if (SQLiteCONN.State == ConnectionState.Closed)
                {
                    SQLiteCONN.Open();
                    B = true;
                }

                if (!B)
                {
                    SQLiteCONN.Open();
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("NOTICE addfile 100: " + ex.Message);
            }

            if (B.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 07: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            using (var CMD = new SQLiteCommand(S, SQLiteCONN))
            {
                try
                {
                    // CMD.Parameters.AddWithValue("FileName", FileName)
                    // CMD.Parameters.AddWithValue("FileHash", FileHash)
                    CMD.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    LOG.WriteToArchiveLog("ERROR 20x: clsDbLocal/addFile - " + ex.Message + Constants.vbCrLf + S);
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

            setSLConn();
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 08: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
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
            using (var CMD = new SQLiteCommand(S, SQLiteCONN))
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
            setSLConn();
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 09: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            int iCnt = 0;
            using (var CMD = new SQLiteCommand(S, SQLiteCONN))
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
            setSLConn();
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 10: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            int iCnt = 0;
            using (var CMD = new SQLiteCommand(S, SQLiteCONN))
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

            setSLConn();
            bool B = true;
            string S = "Delete from Files where FileName = '" + FileName + "' ";
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 11: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
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

            if (FQN.Contains("''"))
            {
                FQN = FQN.Replace("''", "'");
            }

            setSLConn();
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

            FileHash = ENC.GenerateSHA512HashFromFile(FQN);
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
            if (!setSLConn())
            {
                MessageBox.Show("NOTICE 12: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                return Conversions.ToBoolean(0);
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
            try
            {
                CMD.ExecuteNonQuery();
                B = true;
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

            setSLConn();
            LOG.WriteToArchiveLog("NOTICE: Executing SQL: " + Constants.vbCrLf + S);

            // Dim cn As New SqlCeConnection(InvCS)
            if (!setSLConn())
            {
                MessageBox.Show("NOTICE 13: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                return;
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
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
            setSLConn();
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
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 14: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
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

            setSLConn();
            int FileExist = 1;
            int NeedsArchive = 1;
            bool B = true;
            int UseArchiveBit = 0;
            string S = "delete from Inventory where DirID = " + DirID.ToString() + " and FileID = " + FileID.ToString();

            // Dim cn As New SqlCeConnection(InvCS)
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 15: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
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
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 16: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            int iCnt = 0;
            try
            {
                var CMD = new SQLiteCommand(S, SQLiteCONN);
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
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 17: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            string OldHash = "";
            try
            {
                var CMD = new SQLiteCommand(S, SQLiteCONN);
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
            setSLConn();
            // Dim cn As New SqlCeConnection(InvCS)
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 18: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
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
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 19: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
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
            setSLConn();
            try
            {
                var CMD = new SQLiteCommand(S, SQLiteCONN);
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
            setSLConn();
            try
            {
                var CMD = new SQLiteCommand(S, SQLiteCONN);
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
                setSLConn();
                try
                {
                    var CMD = new SQLiteCommand(S, SQLiteCONN);
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
                object val = "";
                long FileSize = 0L;
                DateTime LastUpdate = default;
                DateTime LastArchiveDate = default;
                string S = "";
                FQN = fixSingleQuotes(FQN);
                S = "Select LastArchiveDate, FileLength, LastModDate From DirFilesID D  Where FQN = '" + FQN + "' ";
                S = "Select cast(LastArchiveDate as text) as LAD, FileLength, cast(LastModDate as text) as LMD From DirFilesID   Where FQN = '" + FQN + "' ";
                setSLConn();
                try
                {
                    var CMD = new SQLiteCommand(S, SQLiteCONN);
                    CMD.CommandType = CommandType.Text;
                    var rs = CMD.ExecuteReader();
                    if (rs.HasRows)
                    {
                        rs.Read();
                        try
                        {
                            string LAD = "";
                            LAD = rs.GetString(0);
                            LastArchiveDate = Convert.ToDateTime(LAD);
                        }
                        catch (Exception ex)
                        {
                            LastArchiveDate = Convert.ToDateTime("01-01-1970");
                        }

                        FileSize = rs.GetInt64(1);
                        try
                        {
                            string LAD = "";
                            LAD = rs.GetString(2);
                            LastUpdate = Convert.ToDateTime(LAD);
                        }
                        catch (Exception ex)
                        {
                            LastUpdate = Convert.ToDateTime("01-01-1970");
                        }

                        if (LastUpdate < Convert.ToDateTime("01-01-1970"))
                        {
                            LastUpdate = Convert.ToDateTime("01-01-1970");
                        }

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

            setSLConn();
            string S = "Select FileSize, LastUpdate, NeedsArchive from Inventory where DirID = " + DirID.ToString() + " and FileID = " + FileID.ToString();
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 20: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            int iCnt = 0;
            int prevFileSize = 0;
            DateTime prevLastUpdate = default;
            bool prevNeedsArchive = false;
            try
            {
                var CMD = new SQLiteCommand(S, SQLiteCONN);
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
            setSLConn();
            var CMD = new SQLiteCommand(S, SQLiteCONN);
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
            setSLConn();
            var CMD = new SQLiteCommand(S, SQLiteCONN);
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
            setSLConn();
            var CMD = new SQLiteCommand(S, SQLiteCONN);
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
            setSLConn();
            var CMD = new SQLiteCommand(S, SQLiteCONN);
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
            setSLConn();
            var CMD = new SQLiteCommand(S, SQLiteCONN);
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
            setSLConn();
            var CMD = new SQLiteCommand(S, SQLiteCONN);
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
            setSLConn();
            var CMD = new SQLiteCommand(S, SQLiteCONN);
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

            setSLConn();
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
                var CMD = new SQLiteCommand(S, SQLiteCONN);
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
                if (SQLiteCONN is object)
                {
                    if (SQLiteCONN.State == ConnectionState.Open)
                    {
                        SQLiteCONN.Close();
                    }

                    SQLiteCONN.Dispose();
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
            slDatabase = ConfigurationManager.AppSettings["SQLiteLocalDB"];
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
            slDatabase = ConfigurationManager.AppSettings["SQLiteLocalDB"];
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
            slDatabase = ConfigurationManager.AppSettings["SQLiteLocalDB"];
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

            setSLConn();
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
                var CMD = new SQLiteCommand(S, SQLiteCONN);
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
                if (SQLiteCONN is object)
                {
                    if (SQLiteCONN.State == ConnectionState.Open)
                    {
                        SQLiteCONN.Close();
                    }

                    SQLiteCONN.Dispose();
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

            setSLConn();
            string sKey = null;
            int RowID = default;
            string S = "Select sKey,RowID from Exchange";
            setSLConn();
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 21: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
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
                var CMD = new SQLiteCommand(S, SQLiteCONN);
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
                if (SQLiteCONN is object)
                {
                    if (SQLiteCONN.State == ConnectionState.Open)
                    {
                        SQLiteCONN.Close();
                    }

                    SQLiteCONN.Dispose();
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

            setSLConn();
            bool B = false;
            int UseArchiveBit = 0;
            B = OutlookExists(sKey);
            if (B)
            {
                return true;
            }

            string S = "insert or ignore into Outlook (sKey, RowID) values (@sKey,@RowID) ";
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 22: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
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

            setSLConn();
            bool B = true;
            int UseArchiveBit = 0;
            string S = "insert or ignore into Exchange (sKey,RowID) values (@sKey,@RowID) ";
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 23: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
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

            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 24: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            int iCnt = 0;
            try
            {
                var CMD = new SQLiteCommand(S, SQLiteCONN);
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

            setSLConn();
            bool B = false;
            string S = "Select count(*) from Exchange where sKey = '" + sKey + "'";
            // Dim cn As New SqlCeConnection(InvCS)

            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 25: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            int iCnt = 0;
            try
            {
                var CMD = new SQLiteCommand(S, SQLiteCONN);
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

            setSLConn();
            bool B = true;
            string S = "Update exchange set KeyExists = @B where sKey = @sKey ";
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 26: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
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
            setSLConn();
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 27: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
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

            setSLConn();
            bool B = true;
            string S = "Delete from Outlook where sKey = @sKey ";

            // Dim cn As New SqlCeConnection(FileCS)

            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 28: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
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

            setSLConn();
            bool B = true;
            string S = "Delete from Exchange where sKey = @sKey ";

            // Dim cn As New SqlCeConnection(FileCS)

            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 29: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
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
            setSLConn();
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 30: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
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

            setSLConn();
            bool B = true;
            string S = "Delete from Exchange where not keyExists  ";
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 31: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
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
            setSLConn();
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 32: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
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
            setSLConn();
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 33: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
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
            setSLConn();
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 34: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
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
            setSLConn();
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 35: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
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
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 36: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return;
                }
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
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

            setSLConn();
            bool B = true;
            string S = "insert or ignore into Listener (FQN) values (@FQN) ";
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 37: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
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
            setSLConn();
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 38: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
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
            setSLConn();
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 39: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
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
            setSLConn();
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 40: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
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

            setSLConn();
            string FQN = null;
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 41: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return;
                }
            }

            string S = "Select FQN from Listener";
            try
            {
                var CMD = new SQLiteCommand(S, SQLiteCONN);
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
                // If SQLiteCONN IsNot Nothing Then
                // If SQLiteCONN.State = ConnectionState.Open Then
                // SQLiteCONN.Close()
                // End If
                // SQLiteCONN.Dispose()
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

            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 42: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            int iCnt = 0;
            try
            {
                var CMD = new SQLiteCommand(S, SQLiteCONN);
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

        public bool addZipFile(string FQN, string ParentGuid, bool bThisIsAnEmail)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            int EmailAttachment = 0;
            bool B = true;
            int UseArchiveBit = 0;
            long fSize = 0L;
            if (bThisIsAnEmail)
            {
                EmailAttachment = 1;
            }

            var FI = new FileInfo(FQN);
            fSize = FI.Length;
            FI = null;
            if (FQN.Contains("'"))
            {
                FQN = FQN.Replace("''", "'");
                FQN = FQN.Replace("'", "''");
            }

            if (Information.IsNothing(ParentGuid))
            {
                ParentGuid = "";
            }

            string S = "";
            S = S + "insert or ignore into ZipFile (FQN, fSize, EmailAttachment, ParentGuid) values ('" + FQN + "', " + fSize.ToString() + ", " + EmailAttachment.ToString() + ", '" + ParentGuid + "' ) ";
            try
            {
                SQLiteCONN.Open();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("NOTICE addZipfile 100: " + ex.Message);
            }

            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 44: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
            try
            {
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                if (Strings.InStr(ex.Message, "duplicate value cannot") > 0)
                {
                }
                else
                {
                    LOG.WriteToArchiveLog("ERROR 100H: clsDbLocal/addZipFile - " + ex.Message + Constants.vbCrLf + S);
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
            setSLConn();
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 46: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
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
            setSLConn();
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 47: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
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
            setSLConn();
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 48: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
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
            bool B = true;
            string S = "";
            try
            {
                if (modGlobals.gTraceFunctionCalls.Equals(1))
                {
                    LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
                }

                int UseArchiveBit = 0;
                double fSize = 0d;
                S = "delete from ZipFile where SuccessfullyProcessed = 1 ";
                string db = ConfigurationManager.AppSettings["SQLiteLocalDB"];
                if (!File.Exists(db))
                {
                    MessageBox.Show("FATAL ERR 44 SQLite DB MISSING: " + db);
                }

                string cs = "data source=" + db;
                var SQLiteCONN = new SQLiteConnection();
                using (SQLiteCONN)
                {
                    SQLiteCONN.ConnectionString = cs;
                    SQLiteCONN.Open();
                    var CMD = new SQLiteCommand(S, SQLiteCONN);
                    using (CMD)
                        try
                        {
                            CMD.ExecuteNonQuery();
                        }
                        catch (Exception ex)
                        {
                            LOG.WriteToArchiveLog("ERROR 00: clsDbLocal/cleanZipFiles - " + ex.Message + Constants.vbCrLf + S);
                            B = false;
                        }
                        finally
                        {
                            GC.Collect();
                            GC.WaitForPendingFinalizers();
                        }
                }

                B = true;
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR 01: clsDbLocal/cleanZipFiles - " + ex.Message + Constants.vbCrLf + S);
                B = false;
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
            setSLConn();
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 50: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return Conversions.ToBoolean(0);
                }
            }

            var CMD = new SQLiteCommand(S, SQLiteCONN);
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

            setSLConn();
            string FQN = null;
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 51: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return;
                }
            }

            string S = "Select FQN from ZipFile where InWork = 0";
            try
            {
                var CMD = new SQLiteCommand(S, SQLiteCONN);
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
                // If SQLiteCONN IsNot Nothing Then
                // If SQLiteCONN.State = ConnectionState.Open Then
                // SQLiteCONN.Close()
                // End If
                // SQLiteCONN.Dispose()
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
            if (bSQLiteCOnnected.Equals(false))
            {
                setSLConn();
            }

            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 52: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return;
                }
            }

            try
            {
                var CMD = new SQLiteCommand(S, SQLiteCONN);
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
                if (SQLiteCONN is object)
                {
                    if (SQLiteCONN.State == ConnectionState.Open)
                    {
                        SQLiteCONN.Close();
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
                // bSQLiteCOnnected = True
                catch (Exception ex)
                {
                    bb = false;
                    // bSQLiteCOnnected = False
                }
            }

            return bb;
        }

        /// <summary>
    /// Sets the sl connection.
    /// </summary>
    /// <returns></returns>
        public bool setSLConn()
        {
            bool bb = true;
            string cs = "";
            if (!SQLiteCONN.State.Equals(ConnectionState.Open))
            {
                try
                {
                    string slDatabase = ConfigurationManager.AppSettings["SQLiteLocalDB"];
                    if (!File.Exists(slDatabase))
                    {
                        MessageBox.Show("FATAL ERR SQLite DB MISSING: " + slDatabase);
                    }

                    cs = "data source=" + slDatabase;
                    modGlobals.gLocalDBCS = cs;
                    SQLiteCONN.ConnectionString = cs;
                    SQLiteCONN.Open();
                    bb = true;
                    bSQLiteCOnnected = true;
                }
                catch (Exception ex)
                {
                    var LG = new clsLogging();
                    LG.WriteToArchiveLog("ERROR LOCALDB setSLConn: " + ex.Message + Constants.vbCrLf + cs);
                    LG = null;
                    bb = false;
                    bSQLiteCOnnected = false;
                }
            }

            return bb;
        }

        public object getSLConn()
        {
            var NewConn = new SQLiteConnection();
            string slDatabase = ConfigurationManager.AppSettings["SQLiteLocalDB"];
            string cs = "data source=" + slDatabase;
            try
            {
                NewConn.ConnectionString = cs;
                NewConn.Open();
            }
            catch (Exception ex)
            {
                var LG = new clsLogging();
                LG.WriteToArchiveLog("ERROR LOCALDB getSLConn: " + ex.Message + Constants.vbCrLf + cs);
                LG = null;
                NewConn = null;
            }

            return NewConn;
        }

        public bool closeSLConn()
        {
            bool bb = false;
            if (SQLiteCONN.State.Equals(ConnectionState.Open))
            {
                try
                {
                    SQLiteCONN.Close();
                    bb = true;
                }
                catch (Exception ex)
                {
                    bb = false;
                }
                finally
                {
                    SQLiteCONN.Dispose();
                }
            }

            return bb;
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

        public void getUseLastArchiveDateActive()
        {
            string S = "select cast(LastArchiveDate as text), LastArchiveDateActive from LastArchive";
            setSLConn();
            if (bSQLiteCOnnected.Equals(false))
            {
                if (!setSLConn())
                {
                    MessageBox.Show("NOTICE 52 isUseLastArchiveDateActive: The Local DB failed to open.: " + modGlobals.gLocalDBCS);
                    return;
                }
            }

            string sDate = "";
            DateTime LWD = default;
            string ArchiveFlg = "";
            try
            {
                var CMD = new SQLiteCommand(S, SQLiteCONN);
                CMD.CommandType = CommandType.Text;

                // ** if you don’t set the result set to scrollable HasRows does not work
                var rs = CMD.ExecuteReader();
                if (rs.HasRows)
                {
                    rs.Read();
                    sDate = rs.GetString(0);
                    LWD = Convert.ToDateTime(sDate);
                    ArchiveFlg = rs.GetString(1);
                    try
                    {
                        if (ArchiveFlg.Equals("1"))
                        {
                            modGlobals.gUseLastArchiveDate = "1";
                            modGlobals.gLastArchiveDate = LWD;
                        }
                        else
                        {
                            modGlobals.gUseLastArchiveDate = "0";
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine(ex.Message);
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
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/getUseLastArchiveDateActive - " + ex.Message + Constants.vbCrLf + S);
            }
            finally
            {
                if (SQLiteCONN is object)
                {
                    if (SQLiteCONN.State == ConnectionState.Open)
                    {
                        SQLiteCONN.Close();
                    }
                }
            }
        }

        public void setUseLastArchiveDateActive()
        {
            string S = "update LastArchive set LastArchiveDate = '" + Conversions.ToString(DateAndTime.Now) + "';";
            setSLConn();
            DateTime LWD = default;
            string ArchiveFlg = "";
            var CMD = new SQLiteCommand(S, SQLiteCONN);
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
        }

        public void TurnOffUseLastArchiveDateActive()
        {
            string S = "update LastArchive set LastArchiveDateActive = '0' ";
            setSLConn();
            DateTime LWD = default;
            string ArchiveFlg = "";
            var CMD = new SQLiteCommand(S, SQLiteCONN);
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

            getUseLastArchiveDateActive();
        }

        public int getCountUseLastArchiveDateActive()
        {
            var I = default(int);
            string S = "select count(*) from LastArchive ";
            setSLConn();
            DateTime CNT = default;
            try
            {
                var CMD = new SQLiteCommand(S, SQLiteCONN);
                CMD.CommandType = CommandType.Text;

                // ** if you don’t set the result set to scrollable HasRows does not work
                var rs = CMD.ExecuteReader();
                if (rs.HasRows)
                {
                    while (rs.Read())
                        I = rs.GetInt32(0);
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
                if (SQLiteCONN is object)
                {
                    if (SQLiteCONN.State == ConnectionState.Open)
                    {
                        SQLiteCONN.Close();
                    }
                }
            }

            return I;
        }

        public void setFirstUseLastArchiveDateActive()
        {
            int I = getCountUseLastArchiveDateActive();
            string S = "";
            if (I.Equals(0))
            {
                S = "insert into LastArchive (LastArchiveDate,LastArchiveDateActive) values ('01/01/1960', '0')";
            }
            else
            {
                return;
            }

            setSLConn();
            var CMD = new SQLiteCommand(S, SQLiteCONN);
            try
            {
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/InitUseLastArchiveDateActive - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }

            getUseLastArchiveDateActive();
        }

        public void ZeroizeLastArchiveDate()
        {
            string S = "Delete from LastArchive ";
            setSLConn();
            var CMD = new SQLiteCommand(S, SQLiteCONN);
            try
            {
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/ZeroizeLastArchiveDate - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }
        }

        public void InitUseLastArchiveDateActive(string InitDate)
        {
            var today = DateTime.Now;
            var Day_7 = today.AddDays(-5);
            int I = getCountUseLastArchiveDateActive();
            string S = "";
            if (I.Equals(0) & InitDate.Length.Equals(0))
            {
                S = "insert into LastArchive (LastArchiveDate,LastArchiveDateActive) values ('" + Day_7.ToString() + "', '1')";
            }
            else if (I.Equals(1))
            {
                S = "update LastArchive set LastArchiveDate = '" + InitDate + "' ";
            }
            else if (I > 1)
            {
                ZeroizeLastArchiveDate();
                S = "insert into LastArchive (LastArchiveDate,LastArchiveDateActive) values ('" + InitDate + "', '1')";
            }
            else if (I.Equals(0))
            {
                S = "insert into LastArchive (LastArchiveDate,LastArchiveDateActive) values ('" + InitDate + "', '1')";
            }

            setSLConn();
            var CMD = new SQLiteCommand(S, SQLiteCONN);
            try
            {
                CMD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/InitUseLastArchiveDateActive - " + ex.Message + Constants.vbCrLf + S);
                B = false;
            }
            finally
            {
                CMD.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }

            getUseLastArchiveDateActive();
        }

        public void TurnOnUseLastArchiveDateActive()
        {
            string S = "update LastArchive set LastArchiveDateActive = '1' ";
            setSLConn();
            DateTime LWD = default;
            string ArchiveFlg = "";
            var CMD = new SQLiteCommand(S, SQLiteCONN);
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

            getUseLastArchiveDateActive();
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