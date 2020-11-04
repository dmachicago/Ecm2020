using System;
using System.Collections.Generic;
using global::System.IO;
using System.Windows.Forms;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public class clsDBUpdate
    {
        private List<FileInfo> UpdateINfo = new List<FileInfo>();
        private List<string> FilterList = new List<string>();
        private clsDatabaseARCH DB = new clsDatabaseARCH();
        private clsLogging LOG = new clsLogging();

        public bool CheckForDBUpdates()
        {
            My.MyProject.Forms.frmDBUpdates.Text = "Applying Database Updates";
            FilterList.Clear();
            FilterList.Add("*.sql");
            string FLDR = AppDomain.CurrentDomain.BaseDirectory;
            string UPDTFOLDER = FLDR + @"\DBUpdates";
            if (!Directory.Exists(UPDTFOLDER))
            {
                return true;
            }

            string strFileSize = "";
            var di = new DirectoryInfo(UPDTFOLDER);
            var aryFi = di.GetFiles("*.sql");
            int iline = 0;
            foreach (var fi in aryFi)
            {
                string FName = fi.Name;
                string FQN = fi.FullName;
                var LastWriteTime = fi.LastWriteTime;
                int I = DB.getDBUpdateExists(FQN);
                My.MyProject.Forms.frmDBUpdates.SB.Text = fi.Name;
                My.MyProject.Forms.frmDBUpdates.Refresh();
                Application.DoEvents();
                if (I > 0)
                {
                    var DateApplied = DB.getDBUpdateLastWriteDate(FQN);
                    int secs = SecDiff(LastWriteTime, DateApplied);
                    // If LastWriteTime > DateApplied Then
                    if (secs > 0)
                    {
                        string fn = Path.GetFileName(FQN);
                        LOG.WriteToArchiveLog("APPLYING DB UPDATE: " + fn);
                        My.MyProject.Forms.frmDBUpdates.txtFile.Text = Path.GetFileName(FQN);
                        ApplyUpdate(FQN);
                        LOG.WriteToArchiveLog("COMPLETED DB UPDATE: " + fn);
                        Console.WriteLine("APPLIED");
                    }
                }
                else
                {
                    ApplyUpdate(FQN);
                }
            }

            return default;
        }

        public int SecDiff(DateTime LastWriteTime, DateTime DateApplied)
        {
            int secs = 0;
            var span = LastWriteTime.Subtract(DateApplied);
            return span.Seconds;
        }

        public int ApplyUpdate(string FQN)
        {
            string S = "";
            int Ifailures = 0;
            var reader = My.MyProject.Computer.FileSystem.OpenTextFileReader(FQN);
            string sline = "";
            string tline = "";
            string MySql = "";
            string cs = DB.getRepoConnStr();
            bool B = false;
            int iline = 0;
            using (reader)
            {
                sline = reader.ReadLine();
                do
                {
                    iline += 1;
                    Application.DoEvents();
                    sline = sline.Trim();
                    tline = sline.ToUpper();
                    if (tline.Equals("GO"))
                    {
                        My.MyProject.Forms.frmDBUpdates.txtSql.Text = Path.GetFileName(MySql);
                        My.MyProject.Forms.frmDBUpdates.Refresh();
                        Application.DoEvents();
                        LOG.WriteToDBUpdatesLog("--************************************");
                        LOG.WriteToDBUpdatesLog("--Update File:" + FQN);
                        LOG.WriteToDBUpdatesLog(MySql);
                        B = DB.ExecuteSql(MySql, cs, false);
                        if (B)
                        {
                            B = DB.insertDBUpdate(FQN);
                            if (B)
                            {
                                LOG.WriteToArchiveLog("DB Update applied from " + FQN);
                                B = MarkFileAsApplied(FQN, cs);
                                if (B)
                                {
                                    string FN = Path.GetFileName(FQN);
                                    LOG.WriteToArchiveLog("Notice DB Update:" + FN + " marked as APPLIED.");
                                    DB.updateDBUpdateLastwrite(FQN);
                                }
                            }
                        }
                        else
                        {
                            LOG.WriteToArchiveLog("ERROR: DB Update FAILED from " + FQN + Constants.vbCrLf + MySql);
                        }

                        MySql = "";
                    }
                    else
                    {
                        MySql += sline + Environment.NewLine;
                    }

                    sline = reader.ReadLine();
                }
                while (!(sline is null));
            }

            if (MySql.Trim().Length > 0)
            {
                My.MyProject.Forms.frmDBUpdates.txtSql.Text = Path.GetFileName(MySql);
                LOG.WriteToDBUpdatesLog("--************************************");
                LOG.WriteToDBUpdatesLog("--Update File:" + FQN);
                LOG.WriteToDBUpdatesLog(MySql);
                B = DB.ExecuteSql(MySql, cs, false);
                if (B)
                {
                    B = DB.insertDBUpdate(FQN);
                    if (B)
                    {
                        LOG.WriteToArchiveLog("DB Update applied from " + FQN);
                        B = MarkFileAsApplied(FQN, cs);
                        DB.updateDBUpdateLastwrite(FQN);
                        if (B)
                        {
                            string FN = Path.GetFileName(FQN);
                            LOG.WriteToArchiveLog("Notice DB  Update: " + FN + " marked as APPLIED.");
                        }
                    }
                }
                else
                {
                    LOG.WriteToArchiveLog("ERROR: DB Update FAILED from " + FQN + Constants.vbCrLf + MySql);
                }
            }

            B = MarkFileAsApplied(FQN, cs);
            My.MyProject.Forms.frmDBUpdates.txtSql.Text = "";
            return Ifailures;
        }

        public bool MarkFileAsApplied(string FQN, string cs)
        {
            bool b = true;
            FQN = FQN.Replace("'", "''");
            string MySql = "update DBUpdate set UpdateApplied = 1 where FileName = '" + FQN + "'";
            b = DB.ExecuteSql(MySql, cs, false);
            return b;
        }

        public List<FileInfo> GetFiles(string Path, List<string> FilterList)
        {
            var d = new DirectoryInfo(Path);
            var files = new List<FileInfo>();
            foreach (string Filter in FilterList)
            {
                // the files are appended to the file array
                Application.DoEvents();
                files.AddRange(d.GetFiles(Filter));
            }

            files.Sort(Operators.ConditionalCompareObjectGreaterEqual(f, f.LastWritetime, false));
            return files;
        }
    }
}