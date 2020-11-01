using System;
using System.Collections.Generic;
using System.Data;
using global::System.Data.SqlClient;
using global::System.IO;
using System.Windows.Forms;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public class clsDirListener
    {
        // Inherits clsArchiver
        public bool BUSY = false;
        private int ThreadCnt = 0;
        private SqlConnection SCONN = null;
        private clsLogging LOG = new clsLogging();
        private clsUtility UTIL = new clsUtility();
        private string CS = My.MySettingsProperty.Settings.UserDefaultConnString.ToString();
        private FileSystemWatcher watchfolder;
        private string _Directory = "";
        private string _DirGuid = "";
        private string _SourceFile = "";

        // Dim gFilesToArchive As New List(Of String)
        private List<string> CopyOfFilesToArchive = new List<string>();
        private string _Machinename = "";

        public string SourceFile
        {
            get
            {
                return _SourceFile;
            }

            set
            {
                _SourceFile = value;
            }
        }

        public string DirGuid
        {
            get
            {
                return _DirGuid;
            }

            set
            {
                _DirGuid = value;
            }
        }

        public string WatchDirectory
        {
            get
            {
                return _Directory;
            }

            set
            {
                _Directory = value;
            }
        }

        public string Machinename
        {
            get
            {
                return _Machinename;
            }

            set
            {
                _Machinename = value;
            }
        }

        public bool ExecuteSqlNewConn(string sql)
        {
            bool rc = false;
            var CN = new SqlConnection(CS);
            CN.Open();
            var dbCmd = CN.CreateCommand();
            bool BB = true;
            using (CN)
            {
                dbCmd.Connection = CN;
                try
                {
                    dbCmd.CommandText = sql;
                    dbCmd.ExecuteNonQuery();
                    BB = true;
                }
                catch (Exception ex)
                {
                    rc = false;
                    if (Strings.InStr(ex.Message, "The DELETE statement conflicted with the REFERENCE", CompareMethod.Text) > 0)
                    {
                        if (modGlobals.gRunUnattended == false)
                            MessageBox.Show("It appears this user has DATA within the repository associated to them and cannot be deleted." + Constants.vbCrLf + Constants.vbCrLf + ex.Message);
                        LOG.WriteToArchiveLog("It appears this user has DATA within the repository associated to them and cannot be deleted." + Constants.vbCrLf + Constants.vbCrLf + ex.Message);
                    }
                    else if (Strings.InStr(ex.Message, "HelpText", CompareMethod.Text) > 0)
                    {
                        BB = true;
                    }
                    else if (Strings.InStr(ex.Message, "duplicate key row", CompareMethod.Text) > 0)
                    {
                        // log.WriteToArchiveLog("clsDirListener : ExecuteSqlNewConn : 1464c1 : " + ex.Message)
                        // log.WriteToArchiveLog("clsDirListener : ExecuteSqlNewConn : 1464c1 : " + sql)
                        BB = true;
                    }
                    else if (Strings.InStr(ex.Message, "duplicate key", CompareMethod.Text) > 0)
                    {
                        // log.WriteToArchiveLog("clsDirListener : ExecuteSqlNewConn : 1465c2 : " + ex.Message)
                        // log.WriteToArchiveLog("clsDirListener : ExecuteSqlNewConn : 1464c2 : " + sql)
                        BB = true;
                    }
                    else if (Strings.InStr(ex.Message, "duplicate", CompareMethod.Text) > 0)
                    {
                        // log.WriteToArchiveLog("clsDirListener : ExecuteSqlNewConn : 1466c3 : " + ex.Message)
                        // log.WriteToArchiveLog("clsDirListener : ExecuteSqlNewConn : 1464c3 : " + sql)
                        BB = true;
                    }
                    else
                    {
                        // messagebox.show("Execute SQL: " + ex.Message + vbCrLf + "Please review the trace log." + vbCrLf + sql)
                        BB = false;
                        xTrace(885121, "ExecuteSqlNewConn 10: ", ex.Message.ToString());
                        xTrace(885122, "ExecuteSqlNewConn 10: ", ex.StackTrace.ToString());
                        xTrace(885123, "ExecuteSqlNewConn 10: ", Strings.Mid(sql, 1, 2000));
                        LOG.WriteToArchiveLog("clsDirListener : ExecuteSqlNewConn : 89442a1p1: " + ex.Message);
                        LOG.WriteToArchiveLog("clsDirListener : ExecuteSqlNewConn : 8442a1p1: " + ex.StackTrace);
                        LOG.WriteToArchiveLog("clsDirListener : ExecuteSqlNewConn : 8442a1p2: " + Constants.vbCrLf + sql + Constants.vbCrLf);
                    }
                }
            }

            if (CN.State == ConnectionState.Open)
            {
                CN.Close();
            }

            CN = null;
            dbCmd = null;
            GC.Collect();
            return BB;
        }

        public void CloseConn()
        {
            if (SCONN is null)
            {
            }
            else
            {
                if (SCONN.State == ConnectionState.Open)
                {
                    SCONN.Close();
                }

                SCONN.Dispose();
            }

            GC.Collect();
        }

        public void CkConn()
        {
            if (SCONN is null)
            {
                try
                {
                    SCONN = new SqlConnection();
                    SCONN.ConnectionString = CS;
                    SCONN.Open();
                }
                catch (Exception ex)
                {
                    LOG.WriteToArchiveLog("clsDirListener : CkConn : 338 : " + ex.Message);
                }
            }

            if (SCONN.State == ConnectionState.Closed)
            {
                try
                {
                    SCONN.ConnectionString = CS;
                    SCONN.Open();
                }
                catch (Exception ex)
                {
                    LOG.WriteToArchiveLog("clsDirListener : CkConn : 348 : " + ex.Message);
                }
            }
        }

        public int iCount(string S)
        {
            try
            {
                CloseConn();
                CkConn();
                int Cnt;
                SqlDataReader rsData = null;
                bool b = false;
                var CONN = new SqlConnection(CS);
                CONN.Open();
                var command = new SqlCommand(S, CONN);
                rsData = command.ExecuteReader();
                rsData.Read();
                Cnt = rsData.GetInt32(0);
                rsData.Close();
                rsData = null;
                return Cnt;
            }
            catch (Exception ex)
            {
                xTrace(12306, "clsDirListener:iCount", ex.Message);
                LOG.WriteToArchiveLog("ERROR 1993.21: " + ex.Message);
                LOG.WriteToArchiveLog("clsDirListener : iCount : 2054 : " + ex.Message);
                return -1;
            }
        }

        public SqlDataReader SqlQry(string sql)
        {
            try
            {
                // 'Session("ActiveError") = False
                bool ddebug = true;
                string queryString = sql;
                bool rc = false;
                SqlDataReader rsDataQry = null;
                CloseConn();
                CkConn();
                if (SCONN.State == ConnectionState.Open)
                {
                    SCONN.Close();
                }

                CloseConn();
                CkConn();
                var command = new SqlCommand(sql, SCONN);
                try
                {
                    rsDataQry = command.ExecuteReader();
                }
                catch (Exception ex)
                {
                    LOG.WriteToArchiveLog("clsDatabaseARCH : SqlQry : 1319 : " + ex.Message);
                    LOG.WriteToArchiveLog("clsDatabaseARCH : SqlQry : 1319 Server too Busy : " + Constants.vbCrLf + sql);
                }

                command.Dispose();
                command = null;
                return rsDataQry;
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: SqlQry 100 - Server too busy: " + ex.Message);
            }

            return null;
        }

        public void xTrace(int StmtID, string PgmName, string Stmt)
        {
            if (Stmt.Contains("Failed to save search results"))
            {
                return;
            }

            if (Stmt.Contains("Column names in each table must be unique"))
            {
                return;
            }

            if (Stmt.Contains("clsArchiver:ArchiveQuickRefItems"))
            {
                return;
            }

            try
            {
                FixSingleQuotes(ref Stmt);
                string mySql = "";
                PgmName = UTIL.RemoveSingleQuotes(PgmName);
                mySql = "INSERT INTO PgmTrace (StmtID ,PgmName, Stmt) VALUES(" + StmtID + ", '" + PgmName + "','" + Stmt + "')";
                bool b = ExecuteSqlNewConn(mySql);
                if (b == false)
                {
                    // 'Session("ErrMsg") = "StmtId Call: " + 'Session("ErrMsg")
                    // 'Session("ErrStack") = "StmtId Call Stack: " + ''Session("ErrStack")
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("clsDirListener : xTrace : 1907 : " + ex.Message);
            }
        }

        public void FixSingleQuotes(ref string Stmt)
        {
            int I = 0;
            string CH = "";
            var loopTo = Stmt.Length;
            for (I = 1; I <= loopTo; I++)
            {
                CH = Strings.Mid(Stmt, I, 1);
                if (CH == "'")
                {
                    StringType.MidStmtStr(ref Stmt, I, 1, "`");
                }
            }
        }

        // ** Start the Listeners listening
        public void StartListening(bool IncludeSubDirs)
        {
            try
            {
                watchfolder = new FileSystemWatcher();
                // Add a list of Filters we want to specify, making sure
                // you use OR for each Filter as we need to all of those
                watchfolder.NotifyFilter = NotifyFilters.DirectoryName;
                watchfolder.NotifyFilter = watchfolder.NotifyFilter | NotifyFilters.FileName;
                watchfolder.NotifyFilter = watchfolder.NotifyFilter | NotifyFilters.Attributes;
                watchfolder.NotifyFilter = watchfolder.NotifyFilter | NotifyFilters.Security;
                watchfolder.IncludeSubdirectories = IncludeSubDirs;

                // this is the path we want to monitor
                watchfolder.Path = _Directory;
                watchfolder.Filter = "*.*";

                // add the handler to each event
                watchfolder.Changed += (_, __) => this.DirectoryChange();
                watchfolder.Created += (_, __) => this.DirectoryChange();
                watchfolder.Deleted += (_, __) => this.DirectoryChange();

                // add the rename handler as the signature is different AddHandler watchfolder.Renamed, AddressOf logrename

                // Set this property to true to start watching
                watchfolder.EnableRaisingEvents = true;
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ATTENTION: Listener NOT started for: " + _Directory + Constants.vbCrLf + ex.Message + Constants.vbCrLf + ex.StackTrace.ToString());
            }
        }

        public void StopListening()
        {

            // Stop watching the folder
            watchfolder.EnableRaisingEvents = false;
        }

        public void PauseListening(bool bPause)
        {
            if (bPause == true)
            {
                // Stop watching the folder
                watchfolder.EnableRaisingEvents = false;
            }
            else
            {
                // start watching the folder
                watchfolder.EnableRaisingEvents = true;
            }
        }

        // Sub UploadAwaitingFiles()

        // If gFilesToArchive.Count > 0 Then
        // CopyOfFilesToArchive.Clear()
        // SyncLock Me
        // For IX As Integer = 0 To gFilesToArchive.Count - 1
        // CopyOfFilesToArchive.Add(gFilesToArchive(IX))
        // Next
        // gFilesToArchive.Clear()
        // End SyncLock
        // End If

        // If CopyOfFilesToArchive.Count > 0 Then
        // '** OK _ process the waiting files
        // Application.DoEvents()
        // Dim t As Thread
        // t = New Thread(AddressOf RegisterArchiveFileList)
        // t.Name = "Update: gFilesToArchive " & ThreadCnt.ToString
        // t.Start(CopyOfFilesToArchive)
        // Application.DoEvents()

        // End If

        // End Sub

        // ** This is the heart of the listener -
        // ** One will launch for each listened to directory
        // ** The listener detects a change or addition or deletion to a file
        // ** within a directory or subdirectory
        private bool DirectoryChange(object source, FileSystemEventArgs e)
        {
            if (isListenerPaused() == true)
            {
                modGlobals.gListenerActivityStart = DateAndTime.Now;
                LOG.WriteToArchiveLog("Listener for Dir: " + WatchDirectory + " is disabled.");
                return false;
            }

            BUSY = true;
            string FQN = "";
            bool InstantArchive = true;
            string Description = "";
            string Keywords = "";
            bool isEmailAttachment = false;
            if (e.ChangeType == WatcherChangeTypes.Changed)
            {
                modGlobals.gListenerActivityStart = DateAndTime.Now;
                LOG.WriteListenerLog("CHG" + Conversions.ToString('þ') + e.FullPath);
                LOG.WriteToArchiveLog("File " + e.FullPath + " has been changed.");
                My.MyProject.Forms.frmMain.TimerUploadFiles.Enabled = true;
                if (!modGlobals.gFilesToArchive.ContainsKey(e.FullPath))
                {
                    modGlobals.gFilesToArchive.Add(e.FullPath, modGlobals.gFilesToArchive.Count);
                }
            }
            else if (e.ChangeType == WatcherChangeTypes.Renamed)
            {
                modGlobals.gListenerActivityStart = DateAndTime.Now;
                LOG.WriteListenerLog("NEW" + Conversions.ToString('þ') + e.FullPath);
                LOG.WriteToArchiveLog("File " + e.FullPath + " has been renamed.");
                My.MyProject.Forms.frmMain.TimerUploadFiles.Enabled = true;
                if (!modGlobals.gFilesToArchive.ContainsKey(e.FullPath))
                {
                    modGlobals.gFilesToArchive.Add(e.FullPath, modGlobals.gFilesToArchive.Count);
                }
            }
            else if (e.ChangeType == WatcherChangeTypes.Created)
            {
                modGlobals.gListenerActivityStart = DateAndTime.Now;
                LOG.WriteListenerLog("NEW" + Conversions.ToString('þ') + e.FullPath);
                LOG.WriteToArchiveLog("File " + e.FullPath + " has been created.");
                My.MyProject.Forms.frmMain.TimerUploadFiles.Enabled = true;
                if (!modGlobals.gFilesToArchive.ContainsKey(e.FullPath))
                {
                    modGlobals.gFilesToArchive.Add(e.FullPath, modGlobals.gFilesToArchive.Count);
                }
            }
            else if (e.ChangeType == WatcherChangeTypes.Deleted)
            {
                modGlobals.gListenerActivityStart = DateAndTime.Now;
                LOG.WriteToArchiveLog("File " + e.FullPath + " has been deleted by " + modGlobals.gCurrUserGuidID);
                LOG.WriteListenerLog("DEL" + Conversions.ToString('þ') + e.FullPath);
            }

            BUSY = false;
            return true;
        }

        public void RegisterArchiveFileList(SortedList<string, string> L)
        {
            var DBARCH = new clsDatabaseARCH();
            string SourceFile = "";
            string DirFQN = "";
            try
            {
                bool B = false;
                foreach (string S in L.Keys)
                {
                    string sKey = S;
                    Application.DoEvents();
                    SourceFile = S;
                    int IDX = L.IndexOfValue(S);
                    DirFQN = L.Values[IDX];
                    B = DBARCH.RegisterArchiveFile(SourceFile, DirFQN);
                    modGlobals.gListenerActivityStart = DateAndTime.Now;
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: RegisterArchiveFileList 100 - " + ex.Message);
            }
            finally
            {
                DBARCH = null;
            }
        }

        public bool isListenerPaused()
        {
            bool B = false;
            if (modGlobals.gActiveListeners.IndexOfKey(DirGuid) >= 0)
            {
                B = modGlobals.gActiveListeners[DirGuid];
            }

            return B;
        }
    }
}