// ***********************************************************************
// Assembly         : DIrListen
// Author           : wdale
// Created          : 12-15-2020
//
// Last Modified By : wdale
// Last Modified On : 12-15-2020
// ***********************************************************************
// <copyright file="clsLogging.cs" company="ECM">
//     Copyright ©  2020 DMA, Ltd
// </copyright>
// <summary></summary>
// ***********************************************************************
using System;
using System.Collections.Generic;
using System.Configuration;
//using System.Data.SQLite;
using Microsoft.Data.Sqlite;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading;

namespace ArchiveListener
{
    /// <summary>
    /// Class UTIL.
    /// </summary>
    static public class UTIL
    {
        /// <summary>
        /// The FQN
        /// </summary>
        static public string fqn = "";
        /// <summary>
        /// The log identifier
        /// </summary>
        static public int LogID = 0;
        /// <summary>
        /// The cs
        /// </summary>
        static string CS = "";
        /// <summary>
        /// The ll
        /// </summary>
        public static int LL = 0;
        /// <summary>
        /// The log dir
        /// </summary>
        public static string LogDir = ReadSetting("LogDir");
        /// <summary>
        /// The log path
        /// </summary>
        public static string LogPATH = ReadSetting("DirListenerFilePath");
        /// <summary>
        /// The sq lite listener database
        /// </summary>
        public static string SQLiteListenerDB = ArchiveListener.UTIL.ReadSetting("SQLiteListenerDB");

        /// <summary>
        /// Reads the setting.
        /// </summary>
        /// <param name="key">The key.</param>
        /// <returns>System.String.</returns>
        public static string ReadSetting(string key)
        {
            try
            {
                var appSettings = ConfigurationManager.AppSettings;
                string result = appSettings[key] ?? "Not Found";
                return result;
            }
            catch (ConfigurationErrorsException)
            {
                ArchiveListener.UTIL.LogError("Error reading app settings: '" + key + "'");
                return "Error reading app settings: ";
            }
        }

        /// <summary>
        /// Adds the sq lite file.
        /// </summary>
        /// <param name="ContainingFile">The containing file.</param>
        /// <param name="ListenerDir">The listener dir.</param>
        /// <param name="FQN">The FQN.</param>
        /// <param name="LineID">The line identifier.</param>
        /// <param name="OldFileName">Old name of the file.</param>
        /// <returns>Boolean.</returns>
        public static Boolean AddSQLiteFile(string ContainingFile, string ListenerDir, string FQN, int LineID, string OldFileName)
        {
            LL = 1000;
            Boolean b = true;

            try
            {
                if (OldFileName.Contains("'")){
                    OldFileName.Replace("''", "'");
                    OldFileName.Replace("'", "''");
                }
                if (FQN.Contains("'")){
                    FQN.Replace("''", "'");
                    FQN.Replace("'", "''");
                }
                if (ListenerDir.Contains("'"))
                {
                    ListenerDir.Replace("''", "'");
                    ListenerDir.Replace("'", "''");
                }
                LL = 1001;
                SqliteConnection sqlite_conn = new SqliteConnection();
                LL = 1002;
                CS = "Data Source=" + ArchiveListener.UTIL.SQLiteListenerDB;
                LL = 1003;
                sqlite_conn.ConnectionString = CS;
                sqlite_conn.Open();
                LL = 1004;

                SqliteCommand sqlite_cmd;
                LL = 1005;

                FQN = FQN.Replace("'", "''");
                using (sqlite_conn)
                {
                    LL = 1006;
                    b = true;
                    try
                    {
                        LL = 1007;
                        sqlite_cmd = sqlite_conn.CreateCommand();
                        using (sqlite_cmd)
                        {
                            LL = 1008;
                            if (OldFileName.Trim().Length>0){
                                LL = 1009;
                                sqlite_cmd.CommandText = "INSERT OR IGNORE INTO FileNeedProcessing(ContainingFile,ListenerDir, FQN,LineID,RowCreateDate, OldFileName) VALUES('" + ContainingFile + "','" + ListenerDir +"','" + FQN + "', " + LineID.ToString() + ", '" + DateTime.Now.ToString() + "', '" + OldFileName +"'); ";
                            }
                            else{
                                LL = 1010;
                                sqlite_cmd.CommandText = "INSERT OR IGNORE INTO FileNeedProcessing(ContainingFile,ListenerDir, FQN,LineID,RowCreateDate) VALUES('" + ContainingFile + "','" + ListenerDir + "','" + FQN + "', " + LineID.ToString() + ", '" + DateTime.Now.ToString() + "'); ";
                            }
                            sqlite_cmd.ExecuteNonQuery();
                        }
                        LL = 1011;
                    }
                    catch (Exception ex)
                    {
                        ArchiveListener.UTIL.LogError("ERROR AddSQLiteFile: " + LL.ToString() + " : " + ex.Message);
                        b = false;
                    }
                }
            }
            catch (Exception ex)
            {
                ArchiveListener.UTIL.LogError("ERROR AddSQLiteFile: " + LL.ToString() + " : " + ex.Message);
            }

            return b;
        }

        /// <summary>
        /// Adds the sq lite database.
        /// </summary>
        public static void AddSQLiteDB()
        {
            try
            {
                Int32 i = 0;
                string AppPath = AppDomain.CurrentDomain.BaseDirectory;
                string[] files = Directory.GetFiles(AppPath, "Listener.db", SearchOption.AllDirectories);
                string DBName = "";
                string TgtDir = "";
                TgtDir = Path.GetDirectoryName(SQLiteListenerDB);
                if (!Directory.Exists(TgtDir))
                {
                    Directory.CreateDirectory(TgtDir);
                }
                if (files.Length > 0)
                {
                    for (i = 0; i <= files.Length - 1; i++)
                    {
                        DBName = files[i];
                        if (DBName.ToUpper().Contains("LISTENER.DB"))
                        {
                            string fileToCopy = files[i];
                            string destinationDirectory = SQLiteListenerDB;

                            File.Copy(fileToCopy, destinationDirectory);
                            break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ArchiveListener.UTIL.LogError("ERROR AddSQLiteDB: " + ex.Message);
            }
        }


        /// <summary>
        /// Converts to longtimestring.
        /// </summary>
        /// <returns>System.String.</returns>
        public static string ToLongTimeString()
        {
            DateTime time = DateTime.Now;
            string s = string.Format("{0}.{1}.{2}.{3}", time.Hour, time.Minute, time.Second, time.Hour > 12 ? "PM" : "AM");
            return s;
        }

        /// <summary>
        /// Logs the MSG.
        /// </summary>
        /// <param name="action">The action.</param>
        /// <param name="ListenerDir">The listener dir.</param>
        /// <param name="TrackedFQN">The tracked FQN.</param>
        /// <param name="dir">The dir.</param>
        /// <param name="OldFileName">Old name of the file.</param>
        public static void LogMsg(string action, string ListenerDir, string TrackedFQN, string dir, string OldFileName)
        {
            try
            {
                LogID += 1;
                string EXT = "";

                string strDate = ToLongTimeString();
                string hr = DateTime.Now.Hour.ToString();
                string mo = DateTime.Now.Month.ToString();
                string da = DateTime.Now.Day.ToString();
                string yr = DateTime.Now.Year.ToString();

                if (strDate.Contains("PM"))
                {
                    int ii = Convert.ToInt32(hr);
                    ii += 12;
                    hr = ii.ToString();
                }
                if (hr.Length.Equals(1))
                {
                    hr = "0" + hr;
                }
                if (mo.Length.Equals(1))
                {
                    mo = "0" + mo;
                }
                //string fqn = LogPATH + "\\" + yr + "." + mo + "." + da + "." + hr + "." + "Change.log";
                fqn = LogPATH + "\\" + yr + "." + mo + "." + da + "." + "Change.log";

                string txt = "";
                int i = 0;

                i = TrackedFQN.LastIndexOf(".");
                if (i > 0)
                {
                    EXT = "." + TrackedFQN.Substring(i + 1).ToLower();
                }
                else
                {
                    EXT = "?";
                }

                if (!EXT.Equals("?") && !TrackedFQN.Contains("~"))
                {
                    //AddSQLiteFile(fqn, ListenerDir, TrackedFQN, LogID, OldFileName);
                    //C:\dev\ECM2020\DirListen\DIrListen\bin\Debug\Errors.2020.11.19.log
                    if (!TrackedFQN.Contains("Errors.20") )
                    {
                        new Thread(() => AddSQLiteFile(fqn, ListenerDir, TrackedFQN, LogID, OldFileName)).Start();
                    }                    
                }

                try
                {
                    using (StreamWriter sw = File.AppendText(fqn))
                    {
                        txt = DateTime.Now.ToString() + "|" + LogID.ToString() + "|" + action + "|" + ListenerDir + "|" + dir + "|" + TrackedFQN + "|" + EXT;
                        sw.WriteLine(txt);
                    }
                }
                catch (Exception ex)
                {
                    LogError("UTIL 02: " + ex.Message);
                }
            }
            catch (Exception ex1)
            {
                LogError("ERROR UTIL 03: " + LL.ToString() + ex1.Message);
            }
        }

        /// <summary>
        /// Logs the error.
        /// </summary>
        /// <param name="msg">The MSG.</param>
        static public void LogError(string msg)
        {
            string AppPath = AppDomain.CurrentDomain.BaseDirectory;
            var appSettings = ConfigurationManager.AppSettings;
            string LogFile = appSettings["StaticLog"] ?? "Not Found";

            if (!Directory.Exists(LogFile))
            {
                Directory.CreateDirectory(LogFile);
            }

            LogFile = "Errors." + DateTime.Now.Year.ToString();
            LogFile += "." + DateTime.Now.Month.ToString();
            LogFile += "." + DateTime.Now.Day.ToString();
            LogFile += "." + "log";

            using (StreamWriter w = File.AppendText(LogFile))
            {
                w.WriteLine(DateTime.Now.ToLongTimeString() + " : " + msg);
            }
        }

        /// <summary>
        /// Logs the start up.
        /// </summary>
        /// <param name="msg">The MSG.</param>
        static public void LogStartUp(string msg)
        {
            try
            {
                var appSettings = ConfigurationManager.AppSettings;
                string StartupLog = appSettings["StartupLog"] ?? "Not Found";
                string AppPath = AppDomain.CurrentDomain.BaseDirectory;
                //string[] files = Directory.GetFiles(AppPath, "Listener.db", SearchOption.AllDirectories);
                
                if (!Directory.Exists(LogDir))
                {
                    Directory.CreateDirectory(LogDir);
                }
                
                using (StreamWriter w = File.AppendText(StartupLog))
                {
                    w.WriteLine(DateTime.Now.ToLongTimeString() + " : " + msg);
                }
            }
            catch (Exception ex)
            {
                using (EventLog eventLog = new EventLog("Application"))
                {
                    eventLog.Source = "ECMListenerSVC";
                    eventLog.WriteEntry(ex.Message, EventLogEntryType.Information, 399, 1);
                }
            }
        }
    }
}
