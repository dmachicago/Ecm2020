using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Timers;
//using System.Data.SQLite;
using Microsoft.Data.Sqlite;
using static System.Net.Mime.MediaTypeNames;
using Topshelf;
using System.Diagnostics;
using System.Runtime.InteropServices;
//using System.Runtime.InteropServices;

namespace DirListen
{
    /// <summary>
    /// FSW will work with network drives but since this is a service you 
    /// must make sure your service has network access, by default it won't.  
    /// Thus you can't use a FSW in a service to monitor network drives, by 
    /// default.  Getting over that, also be aware that mapped drives are per
    /// user.Therefore any mapped drives you use must be created inside the
    /// service.
    /// 
    /// Finally note that FSW doesn't work with all network drives.  Even when 
    /// it does you are not guaranteed to get all change notifications.It
    /// depends upon the remote server.
    /// </summary>
    class DirListener
    {
    
        [DllImport("kernel32.dll")]
        static extern IntPtr GetConsoleWindow();

        [DllImport("user32.dll")]
        static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);

        const int SW_HIDE = 0;
        const int SW_SHOW = 5;

        static string CS = "";
        static string RunAsService = ArchiveListener.UTIL.ReadSetting("RunAsService");
        static string HideConsoleWindow = ArchiveListener.UTIL.ReadSetting("HideConsoleWindow");

        static TimeSpan startTimeSpan = TimeSpan.Zero;
        static TimeSpan periodTimeSpan = TimeSpan.FromMinutes(5);
        static int LL = 0;

        static void Main(string[] args)
        {
            LL = 1;
            string LogDir = Path.GetDirectoryName(ArchiveListener.UTIL.LogPATH);
            try
            {
                LL = 2;
                if (!Directory.Exists(LogDir))
                {
                    LL = 3;
                    Directory.CreateDirectory(LogDir);
                }
                LL = 4;
                if (!Directory.Exists(ArchiveListener.UTIL.LogPATH))
                {
                    LL = 5;
                    Directory.CreateDirectory(ArchiveListener.UTIL.LogPATH);
                }

                LL = 6;
                List<string> ListOfDirs = new List<string>();
                ListOfDirs = GetDirsToMoniotor();
                LL = 7;
                string[] dirs = null;
                foreach (string tgtdir in ListOfDirs)
                {
                    dirs = tgtdir.Split('|');
                    if (!dirs[0].Substring(0, 1).Trim().Equals("#"))
                    {
                        LL = 8;
                        MonitorDirectory(dirs);
                    }
                }
                LL = 9;
                if (!File.Exists(ArchiveListener.UTIL.SQLiteListenerDB))
                {
                    LL = 10;
                    ArchiveListener.UTIL.AddSQLiteDB();
                }

                LL = 11;
                RemoveExpiredFiles(null, null);
                LL = 11;
                StartTimers();
                LL = 12;
                if (RunAsService.Equals("0"))
                {
                    if (HideConsoleWindow.Equals("1"))
                    {
                        var handle = GetConsoleWindow();
                        ShowWindow(handle, SW_HIDE);
                    }
                }
                if (RunAsService.Equals("0"))
                {
                    LL = 13;
                    Console.Write("\nPress 'Q' to stop and exist listener...");
                    while (Console.ReadKey().Key != ConsoleKey.Q) ;
                }
                LL = 14;
                if (RunAsService.Equals("1"))
                {
                    LL = 15;
                    ConfigureService.Configure();
                }
                
                LL = 16;
            }
            catch (Exception ex)
            {
                ArchiveListener.UTIL.LogError("MAIN ERROR: " + LL.ToString() + " : " + ex.Message);
            }
            
        }
        
        static SqliteConnection SetListenerConn()
        {
            LL = 100;
            SqliteConnection sqlite_conn = new SqliteConnection();
            try
            {
                LL = 101;
                CS = "Data Source=" + ArchiveListener.UTIL.SQLiteListenerDB;
                sqlite_conn.ConnectionString = CS;
                sqlite_conn.Open();
                LL = 110;
            }
            catch (Exception ex)
            {
                sqlite_conn = null;
                ArchiveListener.UTIL.LogError("ERROR SetListenerConn: " + ex.Message);
            }
            return sqlite_conn;
        }
        static List<string> GetDirsToMoniotor()
        {
            LL = 200;
            try
            {
                LL = 201;
                string DirsFQN = ArchiveListener.UTIL.ReadSetting("DirsToMonitor");
                LL = 202;
                var ArrayOfDirs = File.ReadAllLines(DirsFQN);
                LL = 203;
                var ListOfDirs = new List<string>(ArrayOfDirs);
                LL = 204;
                return ListOfDirs;
            }
            catch (Exception ex)
            {
                ArchiveListener.UTIL.LogError("ERROR GetDirsToMoniotor: "  + LL.ToString() + " : "+ ex.Message);
                return null;
            }

        }
        private static void MonitorDirectory(string[] dirs)
        {
            try
            {
                string ListenerDIR = dirs[0].Trim();
                string IncludeSubs = dirs[1].ToUpper().Trim();
                
                LL = 300;
                if (IncludeSubs.Equals("N")){
                    FileSystemWatcher watcher = new FileSystemWatcher
                    {
                        IncludeSubdirectories = false,
                        Path = ListenerDIR
                    };
                    /* Watch for changes in LastAccess and LastWrite times, and the renaming of files or directories. */
                    //watcher.NotifyFilter = NotifyFilters.LastAccess | NotifyFilters.LastWrite | NotifyFilters.FileName | NotifyFilters.DirectoryName | NotifyFilters.Size;
                    watcher.NotifyFilter = NotifyFilters.LastWrite | NotifyFilters.FileName | NotifyFilters.DirectoryName | NotifyFilters.Size;

                    watcher.Created += FileSystemWatcher_Created;
                    watcher.Renamed += FileSystemWatcher_Renamed;
                    watcher.Deleted += FileSystemWatcher_Deleted;
                    watcher.Changed += FileSystemWatcher_Changed;
                    
                    LL = 302;
                    watcher.EnableRaisingEvents = true;
                    watcher.IncludeSubdirectories = true;
                    LL = 305;
                }
                else {
                    FileSystemWatcher watcher = new FileSystemWatcher
                    {
                        IncludeSubdirectories = true,
                        Path = ListenerDIR
                    };
                    //watcher.NotifyFilter = NotifyFilters.LastAccess | NotifyFilters.LastWrite | NotifyFilters.FileName | NotifyFilters.DirectoryName | NotifyFilters.Size;
                    watcher.NotifyFilter = NotifyFilters.LastWrite | NotifyFilters.FileName | NotifyFilters.DirectoryName | NotifyFilters.Size;
                    watcher.Created += FileSystemWatcher_Created;
                    watcher.Renamed += FileSystemWatcher_Renamed;
                    watcher.Deleted += FileSystemWatcher_Deleted;
                    watcher.Changed += FileSystemWatcher_Changed;
                    LL = 302;
                    watcher.EnableRaisingEvents = true;
                    watcher.IncludeSubdirectories = true;
                    LL = 305;
                }                
                LL = 301;                
            }
            catch (Exception ex)
            {
                ArchiveListener.UTIL.LogError("ERROR MonitorDirectory: " + LL.ToString() + ex.Message);
            }
        }
        private static string GetPath(object sndr) {
            string ListenerDIR = "";
            System.Reflection.PropertyInfo pi = sndr.GetType().GetProperty("Path");
            ListenerDIR = (String)(pi.GetValue(sndr, null));
            return ListenerDIR;
        }
        
        private static void FileSystemWatcher_Changed(object sender, FileSystemEventArgs e)
        {
            LL = 400;
            
            try
            {
                LL = 401;
                string dir = System.IO.Path.GetDirectoryName(e.FullPath);
                string ListenerDIR = "";
                ListenerDIR = GetPath(sender);
                ArchiveListener.UTIL.LogMsg("U", ListenerDIR, e.FullPath, dir, "");
                Console.WriteLine("U|{0} | {1} | {2} | {3}", ListenerDIR, e.Name, dir,"");                
            }
            catch (Exception ex)
            {
                ArchiveListener.UTIL.LogError("ERROR Changed: " + LL.ToString() + ex.Message);
            }
            
        }
        private static void FileSystemWatcher_Created(object sender, FileSystemEventArgs e)
        {
            LL = 400;
            try
            {
                LL = 401;
                string dir = System.IO.Path.GetDirectoryName(e.FullPath);
                String ListenerDIR = "";
                ListenerDIR = GetPath(sender);
                LL = 402;
                ArchiveListener.UTIL.LogMsg("C",ListenerDIR, e.FullPath, dir,"");
                LL = 403;
                Console.WriteLine("U|{0} | {1} | {2} | {3}", ListenerDIR, e.Name, dir, "");
            }
            catch (Exception ex)
            {
                ArchiveListener.UTIL.LogError("ERROR Created: " + LL.ToString() + ex.Message);
            }
        }

        private static void FileSystemWatcher_Renamed(object source, RenamedEventArgs e)
        {
            // Specify what is done when a file is renamed.
            try
            {
                //string OldName = e.Name.
                LL = 501;
                string dir = System.IO.Path.GetDirectoryName(e.FullPath);
                String ListenerDIR = "";
                ListenerDIR = GetPath(source);
                LL = 502;
                ArchiveListener.UTIL.LogMsg("R",ListenerDIR, e.FullPath, dir, e.OldFullPath);
                LL = 503;
                Console.WriteLine("R| {0}|{1}", e.Name, e.OldFullPath);
            }
            catch (Exception ex)
            {
                ArchiveListener.UTIL.LogError("ERROR Rename: " + LL.ToString() + ex.Message);
            }
        }

        private static void FileSystemWatcher_Deleted(object sender, FileSystemEventArgs e)
        {
            LL = 600;
            try
            {
                LL = 601;
                string dir = System.IO.Path.GetDirectoryName(e.FullPath);
                String ListenerDIR = "";
                ListenerDIR = GetPath(sender);
                LL = 602;
                ArchiveListener.UTIL.LogMsg("D", ListenerDIR, e.FullPath, dir,"");
                LL = 603;
                Console.WriteLine("D| {0}|{1}", e.Name,"");
            }
            catch (Exception ex)
            {
                ArchiveListener.UTIL.LogError("ERROR Delete: " + LL.ToString() + ex.Message);
            }            
        }
        
        public static void StartTimers()
        {
            // timer to call MyMethod() every minutes 
            System.Timers.Timer timer = new Timer(TimeSpan.FromMinutes(5).TotalMilliseconds)
            {
                AutoReset = true
            };
            timer.Elapsed += new System.Timers.ElapsedEventHandler(RemoveExpiredFiles);
            timer.Start();
        }

        public static void RemoveExpiredFiles(object sender, ElapsedEventArgs e)
        {
            LL = 800;
            try
            {
                LL = 801;
                string[] files = Directory.GetFiles(ArchiveListener.UTIL.LogPATH);
                String ListenerDIR = "";
                ListenerDIR = GetPath(sender);
                LL = 803;
                foreach (string file in files)
                {
                    LL = 804;
                    FileInfo fi = new FileInfo(file);
                    LL = 805;
                    if (fi.LastAccessTime < DateTime.Now.AddMonths(-7) && fi.Extension.ToLower().Equals(".log"))
                        fi.Delete();
                    LL = 806;
                }
            }
            catch (Exception EX)
            {
                ArchiveListener.UTIL.LogError("ERROR REMOVE fiLES: " + LL.ToString() + EX.Message);
            }
        }
        
        public static void AddSQLiteDir(string ListenerFileName)
        {
            try
            {
                SqliteConnection sqlite_conn = new SqliteConnection();
                CS = "Data Source=" + ArchiveListener.UTIL.SQLiteListenerDB;
                sqlite_conn.ConnectionString = CS;
                sqlite_conn.Open();

                using (sqlite_conn)
                {
                    SqliteCommand sqlite_cmd;
                    sqlite_cmd = sqlite_conn.CreateCommand();
                    using (sqlite_cmd)
                    {
                        sqlite_cmd.CommandText = "INSERT OR IGNORE INTO DirListener(ListenerFileName) VALUES('" + ListenerFileName + "');";
                        sqlite_cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                ArchiveListener.UTIL.LogError("ERROR AddSQLiteDir: " + ex.Message);
            }
        }        
    }

    class ECMListenerSVC
    {
        public void Start()
        {
            try
            {
                // write code here that runs when the Windows Service starts up.  
                ArchiveListener.UTIL.LogStartUp("ECM Listener Service Started:" + DateTime.Now.ToString());
            }
            catch (Exception ex)
            {
                using (EventLog eventLog = new EventLog("Application"))
                {
                    eventLog.Source = "ECMListenerSVC START";
                    eventLog.WriteEntry(ex.Message, EventLogEntryType.Information, 199, 1);
                }
            }
        }
        public void Stop()
        {
            try
            {
                // write code here that runs when the Windows Service stops.  
                ArchiveListener.UTIL.LogStartUp("ECM Listener Service Stopped:" + DateTime.Now.ToString());
            }
            catch (Exception ex)
            {
                using (EventLog eventLog = new EventLog("Application"))
                {
                    eventLog.Source = "ECMListenerSVC STOP";
                    eventLog.WriteEntry(ex.Message, EventLogEntryType.Information, 299, 1);
                }
            }
        }
    }

    internal static class ConfigureService
    {
        internal static void Configure()
        {
            var appSettings = ConfigurationManager.AppSettings;
            string StaticLog = appSettings["StaticLog"] ?? "Not Found";
            try
            {
                HostFactory.Run(configure =>
                {
                    configure.Service<ECMListenerSVC>(service =>
                    {
                        service.ConstructUsing(s => new ECMListenerSVC());
                        service.WhenStarted(s => s.Start());
                        service.WhenStopped(s => s.Stop());
                    });
                    //Setup Account that window service use to run.  
                    configure.RunAsLocalSystem();
                    configure.SetServiceName("ECMListenerSVC");
                    configure.SetDisplayName("ECMListenerSVC");
                    configure.SetDescription("ECMListenerSVC .Net windows service with Topshelf");
                    configure.StartAutomatically();
                });
            }            
            catch (Exception ex)
            {
                using (EventLog eventLog = new EventLog("Application"))
                {
                    eventLog.Source = "ECMListenerSVC Configure Service";
                    eventLog.WriteEntry(ex.Message, EventLogEntryType.Information, 499, 1);
                }
            }
        }
    }

}
