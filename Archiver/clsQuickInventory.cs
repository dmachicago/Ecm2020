using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using global::System.IO;
using System.Linq;
using System.Windows.Forms;
using Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsQuickInventory
    {
        public clsUtility UTIL = new clsUtility();
        public clsLogging LOG = new clsLogging();
        private clsDbLocal DBLocal = new clsDbLocal();
        private clsDatabaseARCH DBA = new clsDatabaseARCH();
        private DataSet DS = null;
        private List<string> ArchiveList = new List<string>();
        private List<string> ListOfDirs = new List<string>();
        private Dictionary<string, string> ListOfAllowedExt = new Dictionary<string, string>();
        private frmNotify FRM = new frmNotify();
        private Dictionary<string, string> DictOfDirs;
        private Dictionary<string, string> DictOfWC = new Dictionary<string, string>();

        public List<string> PerformFastInventory(string MachineName, string UserID)
        {
            FRM.Title = "QUICK Archive with Inventory";
            FRM.Show();
            string Recurse = "";
            try
            {
                getUserDIRS();
                FRM.Label1.Text = "Standby, pulling repo data... ";
                FRM.Refresh();
                Application.DoEvents();
                DS = GetRepoInventory(MachineName, UserID);
                ListOfDirs = DBA.getListOf("select FQN from Directory where UserID = '" + modGlobals.gCurrLoginID + "' and IncludeSubDirs = 'Y' ;");
                FRM.Label1.Text = "Data Pulled";
                FRM.Refresh();
                Application.DoEvents();
                int K = 0;
                foreach (string DirName in DictOfDirs.Keys)
                {
                    try
                    {
                        K += 1;
                        string WhereIN = modGlobals.gWhereInDict[DirName];
                        if (!WhereIN.Equals("0"))
                        {
                            if (Directory.Exists(DirName))
                            {
                                Recurse = DictOfDirs[DirName].ToUpper();
                                ProcessDirectory(DirName, Recurse, WhereIN);
                            }
                            else
                            {
                                LOG.WriteToArchiveLog("NOTICE PerformFastInventory 020: Directory <" + DirName + ">, not found... skipping.");
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        LOG.WriteToArchiveLog("ERROR PerformFastInventory 010: " + ex.Message);
                    }
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR PerformFastInventory 00: " + ex.Message);
            }

            FRM.Dispose();
            FRM.Close();
            My.MyProject.Forms.frmNotify.Close();
            return ArchiveList;
        }

        public IEnumerable<DirectoryInfo> GetAllSubFolders(string path)
        {
            var subFolders = new List<DirectoryInfo>();
            try
            {
                subFolders.AddRange(new DirectoryInfo(path).GetDirectories());
            }
            catch (Exception ex)
            {
                // error handling code goes here'
                Console.WriteLine(ex.Message);
            }

            var innerSubFolders = new List<DirectoryInfo>();
            foreach (var folder in subFolders)
                innerSubFolders.AddRange(GetAllSubFolders(folder.FullName));

            // add the inner sub folders'
            subFolders.AddRange(innerSubFolders);

            // return the directories'
            return subFolders;
        }

        public List<string> GetFilesWithoutErrors(string sourceFolder, string filter)
        {
            var list = new List<string>();
            foreach (string subfolder in Directory.GetDirectories(sourceFolder))
            {
                try
                {
                    list.AddRange(GetFilesWithoutErrors(subfolder, filter));
                }
                catch (Exception __unusedException1__)
                {
                }
            }

            list.AddRange(Directory.GetFiles(sourceFolder, filter));
            return list;
        }

        public int ProcessDirectory(string DirName, string Recurse, string WhereIN)
        {
            var watch = Stopwatch.StartNew();
            if (!Directory.Exists(DirName))
            {
                LOG.WriteToArchiveLog("ERROR: <" + DirName + "> no longer exists, skipping.");
                return 0;
            }

            string AllowedExts = DBA.getIncludedFileTypeWhereIn(modGlobals.gCurrLoginID, DirName);
            AllowedExts = AllowedExts + ",";
            // AllowedExts = WhereIN
            string FQN = "";
            long FileLEngth = 0L;
            var LastWriteDate = DateAndTime.Now;
            string Yr1 = "";
            string Mo1 = "";
            string Da1 = "";
            string Sec1 = "";
            string Yr2 = "";
            string Mo2 = "";
            string Da2 = "";
            string Sec2 = "";
            int iTotal = 0;
            int LL = 0;
            string[] directories = null;
            var ListOfDirs = new List<string>();
            try
            {
                LL = 1000;
                if (Recurse.ToUpper().Equals("Y"))
                {
                    ListOfDirs.Add(DirName);
                    directories = Directory.GetDirectories(DirName, "*.*", SearchOption.AllDirectories);
                    foreach (string sitem in directories)
                    {
                        if (!ListOfDirs.Contains(sitem))
                        {
                            ListOfDirs.Add(sitem);
                        }
                    }

                    directories = null;
                }
                else
                {
                    ListOfDirs.Add(DirName);
                }

                ListOfDirs.Sort();
                int iDirCnt = 0;
                LL = 900;
                foreach (string CurrDir in ListOfDirs)
                {
                    LL = 905;
                    try
                    {
                        iDirCnt += 1;
                        FRM.Label1.Text = "CurrDir: " + iDirCnt.ToString() + " of " + ListOfDirs.Count.ToString();
                        FRM.Refresh();
                        LL = 910;
                        iTotal = 0;

                        // If (CurrDir <> CurrDir + "/System Volume Information") Then
                        if (!CurrDir.ToLower().Contains("volume information"))
                        {
                            var di = new DirectoryInfo(CurrDir);
                            LL = 1;
                            foreach (FileInfo fi in di.GetFiles("*.*", SearchOption.AllDirectories))
                            {
                                iTotal += 1;
                                LL = 2;
                                FRM.lblFileSpec.Text = fi.DirectoryName;
                                FRM.lblPdgPages.Text = "Files #" + iTotal.ToString();
                                Application.DoEvents();
                                try
                                {
                                    if (fi.FullName.Contains(".") & !fi.FullName.Contains(".git") & !fi.FullName.Contains(@"\git\"))
                                    {
                                        LL = 3;
                                        Application.DoEvents();
                                        LL = 4;
                                        // Dim TgtExt As String = fi.Extension.ToLower + ","
                                        string TgtExt = fi.Extension.ToLower() + ",";
                                        string TgtDir = fi.DirectoryName;
                                        LL = 5;
                                        LastWriteDate = fi.LastWriteTime;
                                        FQN = fi.FullName;
                                        LL = 6;
                                        if (TgtExt.Equals(".zip,"))
                                        {
                                            Console.WriteLine("ZIP: " + fi.FullName);
                                        }

                                        if (AllowedExts.Contains(TgtExt))
                                        {
                                            LL = 7;
                                            if (FQN.Contains("'"))
                                            {
                                                FQN = FQN.Replace("''", "'");
                                                FQN = FQN.Replace("'", "''");
                                            }

                                            var Rows = DS.Tables[0].Select("FileLength > 0 And LastWriteTime > #01-01-1900# and  Fqn = '" + FQN + "' ");
                                            LL = 8;
                                            if (Rows.Count().Equals(1))
                                            {
                                                try
                                                {
                                                    LL = 9;
                                                    FileLEngth = Convert.ToInt64(Rows[0]["FileLEngth"]);
                                                    LastWriteDate = Convert.ToDateTime(Rows[0]["LastWriteTime"]);
                                                    LL = 10;
                                                    int CurrnoOfSeconds = (int)Math.Round((DateAndTime.Now - fi.LastWriteTime).TotalMinutes);
                                                    int PrevnoOfSeconds = (int)Math.Round((DateAndTime.Now - LastWriteDate).TotalMinutes);
                                                    LL = 11;
                                                    if (CurrnoOfSeconds < PrevnoOfSeconds | FileLEngth != fi.Length)
                                                    {
                                                        LL = 12;
                                                        ArchiveList.Add(fi.FullName);
                                                    }

                                                    LL = 13;
                                                }
                                                catch (Exception ex)
                                                {
                                                    LOG.WriteToArchiveLog("ERROR ProcessDirectory 100: LL=" + LL.ToString() + Environment.NewLine + FQN + Environment.NewLine + ex.Message);
                                                }
                                            }
                                            else
                                            {
                                                LL = 14;
                                                string fext = Path.GetExtension(FQN);
                                                LL = 15;
                                                ArchiveList.Add(fi.FullName);
                                            }

                                            LL = 16;
                                        }

                                        LL = 17;
                                    }

                                    LL = 18;
                                }
                                catch (Exception ex)
                                {
                                    LOG.WriteToArchiveLog("ERROR ProcessDirectory 11: LL=" + LL.ToString() + Environment.NewLine + FQN + Environment.NewLine + ex.Message);
                                }

                                LL = 19;
                                di = null;
                            }

                            LL = 20;
                        }
                        else
                        {
                            LOG.WriteToArchiveLog("Notice 01: skipping systems directory: LL=" + LL.ToString() + " : " + CurrDir + "/System Volume Information");
                        }
                    }
                    catch (Exception ex)
                    {
                        LOG.WriteToArchiveLog("ERROR ProcessDirectory 22X1: LL=" + LL.ToString() + " : " + "DIRNAME: " + CurrDir + Environment.NewLine + ex.Message);
                    }
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR Processdirectory 00: LL=" + LL.ToString() + "Recurse <" + Recurse + ">" + Environment.NewLine + "DIRNAME: <" + DirName + ">" + Environment.NewLine + "FQN: <" + FQN + ">" + Environment.NewLine + ex.Message);
            }

            watch.Stop();

            // FRM.Close()
            // FRM.Dispose()

            return iTotal;
        }

        public void getUserDIRS()
        {
            DictOfDirs = DBA.GetUserDirectories(modGlobals.gCurrLoginID);
        }

        public string getLIstOfAllowedEXtensions(string DirName, Dictionary<string, string> AllowedExt)
        {
            int Level = 0;
            string exts = DBLocal.getAllowedExtension(DirName, Level, AllowedExt);
            return exts;
        }

        public string getLIstOfAllowedEXtensions(string DirName)
        {
            int Level = 0;
            string exts = DBLocal.getAllowedExtension(DirName, Level, DictOfWC);
            return exts;
        }

        public DataSet GetRepoInventory(string MachineName, string UserID)
        {
            DataSet DS = null;
            var ListOfExts = new List<string>();
            // Dim AllowedExtensions As String = ""

            try
            {
                // AllowedExtensions = AllowedExtensions.Trim
                // AllowedExtensions = AllowedExtensions.Substring(0, AllowedExtensions.Length - 1)
                string AllExts = "";
                ListOfExts = DBA.getListOf("select distinct LOWER(EXtcode) from IncludedFiles where UserID = '" + modGlobals.gCurrLoginID + "' ");
                foreach (string ext in ListOfExts)
                    AllExts = AllExts + "'" + ext + "',";
                AllExts = AllExts.Substring(0, AllExts.Length - 1);
                string MySql = @"Select Fqn , RowGuid, MachineID, UserID, LastWriteTime, FileLength from datasource
                    where MachineID = '" + MachineName + "' and UserID = '" + UserID + "' " + " AND OriginalFileType in (" + AllExts + ")";
                DS = DBA.getDataSet(MySql);
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR GetRepoInventory: " + ex.Message);
            }

            return DS;
        }
    }
}