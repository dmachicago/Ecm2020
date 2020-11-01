using System;
using System.Collections.Generic;
using global::System.IO;
using System.Windows.Forms;
using Microsoft.VisualBasic;
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
            FilterList.Clear();
            FilterList.Add("*.sql");
            string FLDR = AppDomain.CurrentDomain.BaseDirectory;
            string UPDTFOLDER = FLDR + @"\DBUpdates";
            string strFileSize = "";
            var di = new DirectoryInfo(UPDTFOLDER);
            var aryFi = di.GetFiles("*.sql");
            foreach (var fi in aryFi)
            {
                string FName = fi.Name;
                string FQN = fi.FullName;
                var LastWriteTime = fi.LastWriteTime;
                int I = DB.getDBUpdateExists(FQN);
                if (I > 0)
                {
                    var DateApplied = DB.getDBUpdateLastWriteDate(FQN);
                    if (DateApplied < LastWriteTime)
                    {
                        ApplyUpdate(FQN);
                    }
                }
                else
                {
                    ApplyUpdate(FQN);
                }
            }

            return default;
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
            using (reader)
            {
                sline = reader.ReadLine();
                do
                {
                    sline = sline.Trim();
                    tline = sline.ToUpper();
                    if (tline.Equals("GO"))
                    {
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
                                    LOG.WriteToArchiveLog("Notice DB " + FQN + " marked as APPLIED.");
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
                            LOG.WriteToArchiveLog("Notice DB " + FQN + " marked as APPLIED.");
                        }
                    }
                }
                else
                {
                    LOG.WriteToArchiveLog("ERROR: DB Update FAILED from " + FQN + Constants.vbCrLf + MySql);
                }
            }

            B = MarkFileAsApplied(FQN, cs);
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

            return files;
        }
    }
}